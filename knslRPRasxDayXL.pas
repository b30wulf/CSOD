unit knslRPRasxDayXL;

interface

 uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Excel97,ComObj, OleServer ,BaseGrid, AdvGrid, utlconst, utltypes, utldatabase, utlTimeDate,
  utlbox,utlexparcer;
type
  TrpRasxDayXL = class(TForm)
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
    globalTitle       : string;
    globalMeterName   : string;
    glSum             : array [1..4] of string;
    FDB               : PCDBDynamicConn;
    FsgGrid           : PTAdvStringGrid;
    GroupID           : integer;
    FABOID            : integer;
    SumEnergy         : array [0..3,1..4] of extended;
    globalTblMeter    : string;
    glKindEn          : string;
    globalTblDate     : string[15];
    glCountTable      : integer;
    glCountTableShow  : string;
    a_                : integer;
    Page              : byte;
    Excel             : variant;
    Sheet             : variant;
    FProgress         : PTProgressBar;
    //formula
    Fm_nEVL           : CEvaluator;
    sExpr             : string;
    sExpr1            : array [0..3,1..4] of string;
    SumFormula        : array [0..3,1..4] of extended;
    procedure OnFormResize;
    procedure Report1ManualBuild(KindEN : byte);
    procedure frReport1ManualBuild;
    procedure FillReport(MID : integer);
   // procedure FillReportTtl(KindEN : byte);
    procedure ShowData(i:byte);
    procedure FormTitle;
    Function  FindAndReplace(find_,rep_:string):boolean;
    procedure FormFooter(i:byte);
    procedure FindValueFormula(tarif:integer;KindEn: byte;mid:string);
    function  Replace(Str, X, Y: string): string;
  public
    { Public declarations }
    WorksName   : string;
    FirstSign   : string;
    SecondSign  : string;
    ThirdSign   : string;
    DateReport  : TDateTime;
    NDogovor    : string;
    NameObject  : string;
    Adress      : string;
    IsReadZerT  : boolean;
    procedure CreatReport(Date : TDateTime;CountTable :integer);
    procedure PrepareTable;
  public
    property PsgGrid     :PTAdvStringGrid      read FsgGrid      write FsgGrid;
    property prGroupID   :integer              read GroupID      write GroupID;
    property PABOID      :integer              read FABOID       write FABOID;
    property PDB         :PCDBDynamicConn      read FDB          write FDB;
    property PProgress   :PTProgressBar        read FProgress    write FProgress;
    property Pm_nEVL      :CEvaluator           read fm_nEVL      write fm_nEVL;
  end;

var
  rpRasxDayXL: TrpRasxDayXL;
const
  strEnergy   : array [0..3] of string = ('E+',
                                          'E-',
                                          'R+',
                                          'R-');


  PageMasterDataBox   : array [0..3] of byte = (0,
                                          1,
                                          2,
                                          3);
  SumEnerguMasterDataBox   : array [0..4] of string = ('MasterData7',
                                          'MasterData8',
                                          'MasterData9',
                                          'MasterData10',
                                          'Band1');
implementation
constructor TrpRasxDayXL.Create;
Begin

End;

destructor TrpRasxDayXL.Destroy;
Begin
    inherited;
End;



procedure TrpRasxDayXL.OnFormResize;
Var
    i : Integer;
Begin
    if FsgGrid=Nil then exit;
    for i:=1 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1));
End;

procedure TrpRasxDayXL.PrepareTable;
var Meters : SL2TAGREPORTLIST;
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

   if not FDB.GetMeterTableForReport(FABOID,GroupID, Meters) then
     FsgGrid.RowCount := 1
   else
   begin
     FsgGrid.RowCount := 1;
     for i := 0 to Meters.Count - 1 do
     begin
       if (Meters.m_sMeter[i].m_sbyType = MET_SUMM) or (Meters.m_sMeter[i].m_sbyType = MET_GSUMM) then
         continue;
       FsgGrid.Cells[0,FsgGrid.RowCount] := IntToStr(Meters.m_sMeter[i].m_swVMID);
       FsgGrid.Cells[1,FsgGrid.RowCount] := Meters.m_sMeter[i].m_sVMeterName;
       FsgGrid.Cells[2,FsgGrid.RowCount] := Meters.m_sMeter[i].m_sddPHAddres;
       FsgGrid.Cells[3,FsgGrid.RowCount] := DVLS(Meters.m_sMeter[i].m_sfKI*Meters.m_sMeter[i].m_sfKU);
       FsgGrid.Cells[4,FsgGrid.RowCount] := Meters.m_sMeter[i].m_sName;
       FsgGrid.RowCount := FsgGrid.RowCount + 1;
     end;
   end;
   OnFormResize;
end;

procedure TrpRasxDayXL.CreatReport(Date : TDateTime;CountTable:integer);
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
   Excel.WorkBooks.Add(ExtractFileDir(application.ExeName)+'\report\RasxDay.xlt');
   Excel.ActiveSheet.PageSetup.Orientation:= 1;
   Sheet := Excel.Sheets.item[Page];
   Sheet.Name := 'Расход за день_';
   frReport1ManualBuild;
end;

{glEnergMB
    glEnergME
    glEnergRazn
    glEnergRasx
    SumEnergy}


Function  TrpRasxDayXL.FindAndReplace(find_,rep_:string):boolean;
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

procedure TrpRasxDayXL.FormTitle();
begin
        FindAndReplace('#Ndogovor&',Ndogovor);
        FindAndReplace('#WorksName&',WorksName);
        FindAndReplace('#NameObject&',NameObject);
        FindAndReplace('#Adress&',Adress);
        FindAndReplace('#globalTitle&',globalTitle);
        FindAndReplace('#CountTbl&',glCountTableShow);
        FindAndReplace('#glMB&',glMB);
        FindAndReplace('#glME&',glME);
end;

procedure TrpRasxDayXL.ShowData(i:byte);
begin
    Excel.ActiveSheet.Cells[a_+i,3].Value := strEnergy[i];
    Excel.ActiveSheet.Cells[a_+i,4].Value := 'TO';
    Excel.ActiveSheet.Cells[a_+i,5].Value := RVLPr(glEnergMB[4], MeterPrecision[m_ID]);
    Excel.ActiveSheet.Cells[a_+i,6].Value := RVLPr(glEnergME[4], MeterPrecision[m_ID]);
    Excel.ActiveSheet.Cells[a_+i,7].Value := RVLPr(glEnergRazn[4], MeterPrecision[m_ID]);
    Excel.ActiveSheet.Cells[a_+i,8].Value := DVLSEx(glKoef, glKoef);
    Excel.ActiveSheet.Cells[a_+i,9].Value := RVLPr(glEnergRasx[4], MeterPrecision[m_ID]);
end;

function TrpRasxDayXL.Replace(Str, X, Y: string): string;
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

procedure TrpRasxDayXL.FindValueFormula(tarif:integer;KindEn: byte;mid:string);
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

procedure TrpRasxDayXL.FillReport(MID : integer);
var Data                : CCDatas;
    KindEn              : byte;
    Year, Month, Day, i,r : word;
    TempDate            : TDateTime;
    param               : extended;
    nTypeID,swPLID,nMaxT: Integer;

begin

   globalMeterName := '' + FsgGrid.Cells[1, MID];
   globalTblMeter  := 'сч. № :' +FsgGrid.Cells[2, MID];

   a_:= a_+ 4;
   Excel.ActiveSheet.Range['A'+IntToStr(a_)+':B'+IntToStr(a_+3)].Select;
   Excel.ActiveSheet.Range['A'+IntToStr(a_)+':B'+IntToStr(a_+3)].Merge;
   Excel.Selection.WrapText           :=true;
   Excel.Selection.Borders.LineStyle  :=1;
  // Excel.Selection.Borders.Weight           := xlMedium;
   Excel.ActiveSheet.Cells[a_,1].Value := globalMeterName+globalTblMeter;
   m_ID            := StrToInt(FsgGrid.Cells[0, MID]);

    nMaxT  := 3;
    swPLID := 0;
    FDB.GetMeterType(m_ID,nTypeID,swPLID);
    if swPLID=1 then nMaxT:=2;

   for KindEn := 0 to 3 do
   begin
     glKindEn := strEnergy[KindEn];
     glKoef   := StrToFloat(FsgGrid.Cells[3, MID]);
     TempDate := DateReport;
     cDateTimeR.IncDate(TempDate);
    for i := 1 to 4 do
     begin
       glEnergMB[i]   := 0;
       glEnergME[i]   := 0;
       glEnergRazn[i] := 0;
       glEnergRasx[i] := 0;
     end;
     if not FDB.GetGData(TempDate, TempDate, StrToInt(FsgGrid.Cells[0, MID]),
                         QRY_NAK_EN_DAY_EP + KindEn, 0, Data) then
     begin
         FindValueFormula(6,KindEn,FsgGrid.Cells[0, MID]);
         ShowData(PageMasterDataBox[KindEn]);
         continue;
     end;
     for i := 0 to Data.Count - 1 do
       if (Data.Items[i].m_swTID <> 0) and (Data.Items[i].m_swTID <= nMaxT) then
       begin
         glEnergME[Data.Items[i].m_swTID] := Data.Items[i].m_sfValue/glKoef;
         if (IsReadZerT){ or (swPLID=1)} then
           glEnergME[4] := glEnergME[4] + glEnergME[Data.Items[i].m_swTID];
       end
       else
         if (not IsReadZerT) and (Data.Items[i].m_swTID = 0) then //Чтение нулевого тарифа из БД
           glEnergME[4] :=  RVLPr(Data.Items[i].m_sfValue/glKoef, MeterPrecision[m_ID]);
     cDateTimeR.DecDate(TempDate);
     if not FDB.GetGData(TempDate, TempDate, StrToInt(FsgGrid.Cells[0, MID]),
                         QRY_NAK_EN_DAY_EP + KindEn, 0, Data) then
     begin
       FindValueFormula(6,KindEn,FsgGrid.Cells[0, MID]);
       ShowData(PageMasterDataBox[KindEn]);
       continue;
     end;
     for i := 0 to Data.Count - 1 do
       if (Data.Items[i].m_swTID <> 0) and (Data.Items[i].m_swTID <= nMaxT) then
       begin
         glEnergMB[Data.Items[i].m_swTID] := Data.Items[i].m_sfValue/glKoef;
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
        ShowData(PageMasterDataBox[KindEn]);
    end;
end;

procedure TrpRasxDayXL.FormFooter(i:byte);
begin

    Excel.ActiveSheet.Cells[a_+i,3].Value := strEnergy[i];
    Excel.ActiveSheet.Cells[a_+i,4].Value := 'TO';
    Excel.ActiveSheet.Cells[a_+i,9].Value := glSum[4]
end;

procedure TrpRasxDayXL.Report1ManualBuild(KindEN : byte);
var i : byte;
begin
if KindEn<4 then
   if  sExpr <> '[x]' then
   begin
   try
       fm_nEVL.Expression :=  sExpr1[KindEn][4];  //формула
       if fm_nEVL.Value < 0 then glSum[4] := 'Н/Д' else
       glSum[4] := FloatToStr(RVLPr(fm_nEVL.Value, MaxPrecision));
   except
        MessageDlg('Ошибка в вычислениях',mtWarning,[mbOk,mbCancel],0);
        exit;
   end;
   end
   else
   begin
   if SumEnergy[KindEn][4] < 0 then glSum[4] := 'Н/Д' else
   glSum[4] := FloatToStr(RVLPr(SumEnergy[KindEn][4], MaxPrecision));
   end;

   FormFooter(KindEn);
end;

procedure TrpRasxDayXL.frReport1ManualBuild;
var i, j             : integer;
    Month,Month1, Year,Year1, Day : word;
    TempDate         : TDateTime;
    pGT              : SL3GROUPTAG;
begin
    ////инициализация //формулы
 sExpr := m_pDB.GetMSGROUPEXPRESS(FABOID,GroupID,pGT);
 fm_nEVL.Expression := sExpr;
 for i:=1 to 4 do
    for j:=0 to 3 do
       sExpr1[j][i] := sExpr;
 //////////////
   FProgress.Create(Owner);
   FProgress.Visible := true;
   a_:= 8;
  for i := 0 to 3 do
     for j := 1 to 4 do
      SumEnergy[i][j] := 0;
   TempDate  := DateReport;
   DecodeDate(DateReport, Year, Month, Day);
   globalTitle := 'Сведения о расходе электроэнергии по точкам учета в ' +
                                            cDateTimeR.GetNameMonth(Month)+ ' ' + IntToStr(Year) + ' года';

   cDateTimeR.IncDate(DateReport);
   glME := DateToStr(DateReport);
   cDateTimeR.DecDate(DateReport);
   glMB := DateToStr(DateReport);
   glCountTableShow := 'Таблица № ' + IntToStr(glCountTable);
   FormTitle();
   FProgress.Max:= FsgGrid.RowCount;
   for i := 1 to FsgGrid.RowCount - 1 do
   begin
   FProgress.Position := i;
   FillReport(i);
   glCountTableShow := 'Таблица № ' + IntToStr(glCountTable) + '(продолжение)';
   end;
   a_    := a_+ 4;
   Excel.ActiveSheet.Range['A'+IntToStr(a_)+':B'+IntToStr(a_)].Select;
   Excel.ActiveSheet.Range['A'+IntToStr(a_)+':B'+IntToStr(a_)].Merge;
   Excel.ActiveSheet.Cells[a_,1].Value := 'Итого по:';
   Excel.ActiveSheet.Cells[a_,9].Value := 'Сумма';
   a_    := a_ + 1;
   Excel.ActiveSheet.Range['A'+IntToStr(a_)+':B'+IntToStr(a_+1)].Select;
   Excel.ActiveSheet.Range['A'+IntToStr(a_)+':B'+IntToStr(a_+1)].Merge;
   Excel.Selection.WrapText:=true;
   Excel.Selection.Borders.LineStyle:=1;
 //  Excel.Selection.Borders.Weight           := xlMedium;
   Excel.ActiveSheet.Cells[a_,1].Value := 'Активная энергия(кВт*ч)';

   Excel.ActiveSheet.Range['A'+IntToStr(a_+2)+':B'+IntToStr(a_+3)].Select;
   Excel.ActiveSheet.Range['A'+IntToStr(a_+2)+':B'+IntToStr(a_+3)].Merge;
   Excel.Selection.WrapText:=true;
   Excel.Selection.Borders.LineStyle:=1;
 //  Excel.Selection.Borders.Weight           := xlMedium;
   Excel.ActiveSheet.Cells[a_+2,1].Value := 'Реактивная энергия(кВар*ч)';

   for i := 0 to 3 do
   Report1ManualBuild(i);

   Excel.ActiveWorkBook.WorkSheets[1].Range['A12:I'+IntToStr(a_+3)].Select;//выделяем всю таблицу
   Excel.Selection.Borders.LineStyle:=1;//устанавливаем границы
 //  Excel.Selection.Borders.Weight           := xlMedium;
   Excel.Selection.HorizontalAlignment:=-4108;
   Excel.ActiveSheet.PageSetup.PrintTitleRows:='$1:$11 ';// при печати на каждой странице ввыводится шапка
   Excel.ActiveSheet.PageSetup.LeftFooter :='&8'+FirstSign + SecondSign + ThirdSign;
   try
      FProgress.Position:=0;
      Excel.Visible := true;
    finally
     if not VarIsEmpty(Excel) then
    begin
      // Excel.DisplayAlerts := False;
      //Excel.Quit;
      Excel             := Unassigned;
      Sheet             := Unassigned;
      FProgress.Visible := false;
      FProgress.Enabled := false;
      FProgress         := nil;
      //fm_nEVL.Free;
     end;
end;
end;

end.
