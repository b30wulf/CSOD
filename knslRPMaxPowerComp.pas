unit knslRPMaxPowerComp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComObj, OleServer ,BaseGrid, AdvGrid, utlconst, utltypes, utldatabase, utlTimeDate,
  utlbox,utlexparcer,Word97,IniFiles, utldynconnect;

type
  TRPMaxPowerComp = class
  private
    { Private declarations }
    FDB               : PCDBDynamicConn;
    FsgGrid           : PTAdvStringGrid;
    FProgress         : PTProgressBar;
    Word              : Variant;
    EngenName         : string;
    AllowAbonStr      : string;
    AllowAbonBuf      : array of integer;
    m_Tariffs         : TM_TARIFFS;
    m_AbonInfo        : SL3ABONS;
    dtBegDate         : TDateTime;
    dtEndDate         : TDateTime;
    procedure BuildReport(BuildType : integer);
    procedure LoadParamsFromInf;
    procedure CreateRPTitle;
    procedure CreateTbl;
    procedure FillMaxValues(RPType : integer); 
    procedure CreateRPFooter;
    procedure TableLineSet;
    procedure OutTextToTable(x, y, fs, al : integer; tstr : string);
    procedure SaveDocument;
    procedure ShowDocument;
    function  GetColorFromTariffs(Srez:byte; var pTable:TM_TARIFFS):Byte;
  public
    { Public declarations }
    dtRpDate          : TDateTime;
    procedure OnFormResize;
    procedure PrepareTable;
    procedure CreateReport;
    procedure CreateReportHidden;
  public
    property PsgGrid     :PTAdvStringGrid  read FsgGrid      write FsgGrid;
    property PProgress   :PTProgressBar    read FProgress    write FProgress;
    property PDB         :PCDBDynamicConn   read FDB          write FDB;
  end;

var
  RPMaxPowerComp : TRPMaxPowerComp;

implementation

procedure TRPMaxPowerComp.PrepareTable;
var Abons  : SL3ABONS;
    i      : integer;
begin
   if FsgGrid=Nil then
     exit;
   FsgGrid.ColCount   := 3;
   FsgGrid.Cells[0,0] := '№ п.п';
   FsgGrid.Cells[1,0] := 'Наименование абонента';
   FsgGrid.Cells[2,0] := 'Выбор абонентов';
   FsgGrid.ColWidths[0]  := 30;
   if not FDB.GetAbonsTable(Abons) then
     FsgGrid.RowCount := 1
   else
   begin
     FsgGrid.RowCount := Abons.Count + 1;
     for i := 0 to Abons.Count - 1 do
     begin
       FsgGrid.Cells[0, i + 1] := IntToStr(Abons.Items[i].m_swABOID);
       FsgGrid.Cells[1, i + 1] := Abons.Items[i].m_sName;

     end;
   end;
   OnFormResize;
end;

procedure TRPMaxPowerComp.OnFormResize;
Var
    i : Integer;
Begin
    if FsgGrid=Nil then exit;
    for i:=1 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1));
    //PChild.OnFormResize;
end;

procedure TRPMaxPowerComp.CreateReport;

begin
   try
   Word := CreateOleObject('Word.Application');
   except
     MessageDlg('На компьютере отсутствует MS Office Word или не та версия', mtWarning, [mbOK], 0);
     exit;
   end;
   Word.Documents.Add(ExtractFilePath(Application.ExeName) + '\report\MaxPowerCompany.doc');

   try
     BuildReport(0);
   except
     Word.Quit;
     exit;
   end;
end;

procedure TRPMaxPowerComp.CreateReportHidden;
begin
   try
   Word := CreateOleObject('Word.Application');
   except
     MessageDlg('На компьютере отсутствует MS Office Word или не та версия', mtWarning, [mbOK], 0);
     exit;
   end;
   Word.Documents.Add(ExtractFilePath(Application.ExeName) + '\report\MaxPowerCompany.doc');

   try
     BuildReport(1);
   except
     Word.Quit;
     exit;
   end;
end;

procedure TRPMaxPowerComp.BuildReport(BuildType : integer);
Var
   m_nDescDB : Integer;
begin
   //FDB := CDBDynamicConn.Create(m_pDB.m_strProvider);
   FDB := m_pDB.CreateConnectEx(m_nDescDB);
   dtBegDate := cDateTimeR.DecMonth1(dtRpDate);
   dtEndDate := cDateTimeR.EndMonth(dtBegDate);
   dtEndDate := cDateTimeR.EndDateDay(dtEndDate);
   LoadParamsFromInf;
   CreateRPTitle;
   CreateTbl;
   if BuildType = 0 then FProgress.Max := m_AbonInfo.Count;
   FillMaxValues(BuildType);
   CreateRPFooter;
   if BuildType = 0 then
     ShowDocument
   else
     SaveDocument;
   m_pDB.DynDisconnectEx(m_nDescDB);
   //FDB.Destroy;
end;

procedure TRPMaxPowerComp.LoadParamsFromInf;
var Fl   : TINIFile;
begin
   Fl := TINIFile.Create(ExtractFilePath(Application.ExeName) + '\\Settings\\' + 'reprot_Config.ini');
   AllowAbonStr := Fl.ReadString('MAXPOWERCOMP', 'm_nAllowAbon', '');
   SetLength(AllowAbonBuf, Length(AllowAbonStr) div 2 + 10);
   GetIntArrayFromStr(AllowAbonStr, AllowAbonBuf);
   EngenName := Fl.ReadString('MAXPOWERCOMP', 'm_nPredstEnergo', '');
   SetLength(m_Tariffs.Items, 3);
   m_Tariffs.Count := 3;
   try
     m_Tariffs.Items[1].m_swTID := 1;
     m_Tariffs.Items[1].m_dtTime0 := StrToTime(Fl.ReadString('MAXPOWERCOMP', 'edMornBeg', '08:00:00'));
     m_Tariffs.Items[1].m_dtTime1 := StrToTime(Fl.ReadString('MAXPOWERCOMP', 'edMornEnd', '11:00:00'));

     m_Tariffs.Items[2].m_swTID := 2;
     m_Tariffs.Items[2].m_dtTime0 := StrToTime(Fl.ReadString('MAXPOWERCOMP', 'edEvnBeg', '08:00:00'));
     m_Tariffs.Items[2].m_dtTime1 := StrToTime(Fl.ReadString('MAXPOWERCOMP', 'edEvnEnd', '11:00:00'));
   except
     m_Tariffs.Items[1].m_dtTime0 := StrToTime('08:00:00');
     m_Tariffs.Items[1].m_dtTime1 := StrToTime('11:00:00');

     m_Tariffs.Items[2].m_swTID := 2;
     m_Tariffs.Items[2].m_dtTime0 := StrToTime('8:00:00');
     m_Tariffs.Items[2].m_dtTime1 := StrToTime('11:00:00');
   end;
   Fl.Destroy;
end;

procedure TRPMaxPowerComp.CreateRPTitle;
var Year, Month, Day : _WORD;
begin
   DecodeDate(dtRpDate, Year, Month, Day);
   Word.Selection.Font.Size := 18;
   Word.Selection.ParagraphFormat.Alignment := wdAlignParagraphCenter;
   Word.Selection.TypeText('Акт');
   Word.Selection.TypeParagraph;
   Word.Selection.Font.Size := 16;
   Word.Selection.TypeText('Проверки нагрузки в часы максимума энергосистемы (по системе АСКУЭ)');
   Word.Selection.TypeParagraph;
   Word.Selection.Font.Size := 12;
   Word.Selection.TypeText('Представитель филиала "Энергосбыт" РУП "Минскэнерго" ' + EngenName);
   Word.Selection.TypeParagraph;
   Word.Selection.TypeText('(должность, фамилия, имя, отчество)');
   Word.Selection.TypeParagraph;
   Word.Selection.TypeText('Составили настоящий акт фактической нагрузки потребителя в часы максимума энергосистемы ' +
        ' 1 ' + cDateTimeR.GetNameMonth1(Month) + ' ' + IntToStr(Year) + ' г.(за '
        );
   DecodeDate(cDateTimeR.DecMonth1(dtRpDate), Year, Month, Day);
   Word.Selection.TypeText(cDateTimeR.GetNameMonth0(Month) + ' месяц).');
   Word.Selection.TypeParagraph;
   Word.Selection.TypeParagraph;
end;

procedure TRPMaxPowerComp.CreateTbl;
var tstr   : string;
    i      : integer;
    rc, cc : integer;
begin
   tstr := '(-1,';
   for i := 0 to Length(AllowAbonBuf) - 1 do
     if AllowAbonBuf[i] <> -100 then
       tstr := tstr + IntToStr(AllowAbonBuf[i]) + ',';
   if (tstr[length(tstr)] = ',') then
     tstr[length(tstr)] := ' ';
   tstr := tstr + ')';
   PDB.GetAbonTableS(tstr, m_AbonInfo);
   rc :=  m_AbonInfo.Count + 1;
   cc := 7;
   Word.Selection.Tables.Add(Word.Selection.Range, rc, cc);
   for i := 1 to cc do
   begin
     Word.ActiveDocument.Tables.Item(1).columns.item(i).select;
     TableLineSet;
   end;
   Word.ActiveDocument.Tables.Item(1).columns.item(1).Width:=90;
   Word.ActiveDocument.Tables.Item(1).columns.item(2).Width:=200;
   Word.ActiveDocument.Tables.Item(1).columns.item(3).Width:=70;
   Word.ActiveDocument.Tables.Item(1).columns.item(4).Width:=70;
   Word.ActiveDocument.Tables.Item(1).columns.item(5).Width:=70;
   OutTextToTable(1, 1, 12, wdAlignParagraphCenter, '№');
   OutTextToTable(2, 1, 12, wdAlignParagraphCenter, 'Наименование потребителя');
   OutTextToTable(3, 1, 12, wdAlignParagraphCenter, 'Договорная величина активной мощности');
   OutTextToTable(4, 1, 12, wdAlignParagraphCenter, 'Максимальная мощность с ' + FormatDateTime('hh:nn', m_Tariffs.Items[1].m_dtTime0) +
                                ' до ' + FormatDateTime('hh:nn', m_Tariffs.Items[1].m_dtTime1) + ' (Pфактическая-кВт)');
   OutTextToTable(5, 1, 12, wdAlignParagraphCenter, 'Максимальная мощность с ' + FormatDateTime('hh:nn', m_Tariffs.Items[2].m_dtTime0) +
                                ' до ' + FormatDateTime('hh:nn', m_Tariffs.Items[2].m_dtTime1) + ' (Pфактическая-кВт)');
   OutTextToTable(6, 1, 12, wdAlignParagraphCenter, 'Договорной тариф');
   OutTextToTable(7, 1, 12, wdAlignParagraphCenter, 'Расчётный тариф');
   for i := 0 to m_AbonInfo.Count - 1 do
   begin
     OutTextToTable(1, i + 2, 12, wdAlignParagraphLeft, m_AbonInfo.Items[i].m_sDogNum);
     OutTextToTable(2, i + 2, 12, wdAlignParagraphLeft, m_AbonInfo.Items[i].m_sName);
     OutTextToTable(3, i + 2, 12, wdAlignParagraphLeft, FloatToStr(m_AbonInfo.Items[i].m_sMaxPower));
     OutTextToTable(6, i + 2, 10, wdAlignParagraphLeft, 'Двухставочно-дифференцированный по зонам суток Pфакт.');
     OutTextToTable(7, i + 2, 10, wdAlignParagraphLeft, 'Двухставочно-дифференцированный по зонам суток Pфакт.');
   end;
end;

procedure TRPMaxPowerComp.FillMaxValues(RPType : integer);
var i, j, sl, TID : integer;
    pTable        : L3GRAPHDATAS;
    max_M, max_E  : double;
begin
   for i := 0 to m_AbonInfo.Count - 1 do
   begin
     max_M := 0;
     max_E := 0;
     if RPType = 0 then FProgress.Position := i;
     PDB.GetGraphDatasABON(dtEndDate, dtBegDate, m_AbonInfo.Items[i].m_swABOID, QRY_SRES_ENR_EP, pTable);
     for j := 0 to pTable.Count - 1 do
     begin
       for sl := 0 to 47 do
       begin
         TID := GetColorFromTariffs(sl, m_Tariffs);
         if (TID = 1) then
           if max_M < pTable.Items[j].v[sl] then
             max_M := pTable.Items[j].v[sl];
         if (TID = 2) then
           if max_E < pTable.Items[j].v[sl] then
             max_E := pTable.Items[j].v[sl];
       end;
     end;
     OutTextToTable(4, i + 2, 12, wdAlignParagraphLeft, RVLPrStr(max_M * 2, 3));
     OutTextToTable(5, i + 2, 12, wdAlignParagraphLeft, RVLPrStr(max_E * 2, 3));
   end;
end;

procedure TRPMaxPowerComp.CreateRPFooter;
var Unit_, Extend_: OleVariant;
begin
   Unit_ := wdStory;
   Extend_ := wdMove;
   Word.Selection.EndKey(Unit_, Extend_);
   Word.Selection.TypeParagraph;
   Word.Selection.ParagraphFormat.Alignment := wdAlignParagraphLeft;
   Word.Selection.Font.Size := 12;
   Word.Selection.TypeText('Примечание при не предоставлении данных замера необходимо предоставлять служебную записку, обосновывающую невозможность проведения замера.');
   Word.Selection.TypeParagraph;
   Word.Selection.TypeText('Представитель филиала "Энергосбыт"___________________________');
end;

procedure TRPMaxPowerComp.SaveDocument;
 var Year, Month, Day: _WORD;
begin
  DecodeDate(dtRpDate, Year, Month, Day);
   try
     Word.ActiveDocument.SaveAs(ExtractFilePath(Application.ExeName) + '\ExportReport\MaxPowerComp_' + FormatDateTime('yymm', dtRpDate) + '.doc');
   except
     Word.Quit;
     exit;
   end;

   Word.Quit;
end;

procedure TRPMaxPowerComp.ShowDocument;
begin
   try
     Word.Visible := true;
   finally
     if not VarIsEmpty(Word) then
     begin
       Word.Quit;
       Word := Unassigned;
     end;
   end;
end;

procedure TRPMaxPowerComp.TableLineSet;
begin
   Word.Selection.Cells.Borders.Item(wdBorderLeft).LineStyle:=wdLineStyleSingle;
   Word.Selection.Cells.Borders.Item(wdBorderRight).LineStyle:= wdLineStyleSingle;
   Word.Selection.Cells.Borders.Item(wdBorderHorizontal).LineStyle:= wdLineStyleSingle;
   Word.Selection.Cells.Borders.Item(wdBorderTop).LineStyle:= wdLineStyleSingle;
   Word.Selection.Cells.Borders.Item(wdBorderBottom).LineStyle:= wdLineStyleSingle;
   Word.Selection.Cells.Borders.Item(wdBorderVertical).LineStyle:= wdLineStyleSingle;
end;

procedure TRPMaxPowerComp.OutTextToTable(x, y, fs, al : integer; tstr : string);
begin
   Word.ActiveDocument.Tables.Item(1).Cell(y, x).select;
   Word.selection.font.size:=fs;
   Word.Selection.ParagraphFormat.Alignment := al;
   Word.selection.typetext(tstr);
end;

function TRPMaxPowerComp.GetColorFromTariffs(Srez:byte; var pTable:TM_TARIFFS):Byte;
var SumS                         : _WORD;
    Hour0, Min0, Sec0, ms0, Sum0 : _WORD;
    Hour1, Min1, Sec1, ms1, Sum1 : _WORD;
    i                            : integer;
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

end.
