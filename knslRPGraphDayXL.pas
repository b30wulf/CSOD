unit knslRPGraphDayXL;

interface

 uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Excel97,ComObj, OleServer ,BaseGrid, AdvGrid, utlconst, utltypes, utldatabase, utlTimeDate,
  utlbox,utlexparcer;
type
  TRPGraphDayXL = class(TForm)
  constructor Create;
  destructor Destroy;override;
 private
    { Private declarations }
    Data              : L3GRAPHDATAS;
    m_pTariffs        : TM_TARIFFS;
    m_ID              : byte;
    FTID              : integer;
    FsgGrid           : PTAdvStringGrid;
    GroupID           : integer;
    FABOID            : integer;
    glKoef            : extended;
    MeterN            : string;
    glMB              : string[15];
    glME              : string[15];
    globalTitle       : string;
    globalMeterName   : string;
    glSum             : array [1..4] of string;
    maxArray          : array [1..4] of Double;
    sumTarrif         : array [1..4] of Double;
    numHalfHour       : array [1..4] of Integer;
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
    FProgress         : PTProgressBar;
    Fm_nEVL            : CEvaluator;
    procedure FillReport(MID : integer);
    procedure frReport1ManualBuild;
    procedure FormTitle;
    procedure FormTitle2;
    Function  FindAndReplace(find_,rep_:string):boolean;
    procedure ShowData1;
    procedure FillInfoPower();
    procedure FillTitle;
    function  Replace(Str, X, Y: string): string;
    procedure SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
    procedure OnFormResize;
    function  GetColorFromTariffs(Srez:byte; var pTable:TM_TARIFFS):Byte;
    procedure FindMaxAndSumTar;
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
    IsReadZerT   : boolean;
    ItemInd      : integer;
   procedure CreatReport(Date : TDateTime;CountTable:integer);
   procedure PrepareTable;
  public
    property PsgGrid     :PTAdvStringGrid    read FsgGrid      write FsgGrid;
    property prGroupID   :integer            read GroupID      write GroupID;
    property PABOID      :integer            read FABOID       write FABOID;
    property PDB         :PCDBDynamicConn    read FDB          write FDB;
    property PProgress   :PTProgressBar      read FProgress    write FProgress;
    property Pm_nEVL      :CEvaluator        read fm_nEVL      write fm_nEVL;
  end;

var
  RPGraphDayXL  : TRPGraphDayXL;
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

constructor TRPGraphDayXL.Create;
Begin

End;

destructor TRPGraphDayXL.Destroy;
Begin
    inherited;
End;

function TRPGraphDayXL.GetColorFromTariffs(Srez:byte; var pTable:TM_TARIFFS):Byte;
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

procedure TRPGraphDayXL.PrepareTable;
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
     FsgGrid.RowCount := Meters.Count+1;
     for i := 0 to Meters.Count - 1 do
     begin
       {if (Meters.m_sMeter[i].m_sbyType = MET_SUMM) or (Meters.m_sMeter[i].m_sbyType = MET_GSUMM) then
         continue;
       }
       if (Meters.m_sMeter[i].m_sbyType = MET_VZLJOT) then
         continue;
       FsgGrid.Cells[0,i+1] := IntToStr(Meters.m_sMeter[i].m_swVMID);
       FsgGrid.Cells[1,i+1] := Meters.m_sMeter[i].m_sVMeterName;
       FsgGrid.Cells[2,i+1] := Meters.m_sMeter[i].m_sddPHAddres;
       FsgGrid.Cells[3,i+1] := DVLS(Meters.m_sMeter[i].m_sfKI*Meters.m_sMeter[i].m_sfKU);
       FsgGrid.Cells[4,i+1] := Meters.m_sMeter[i].m_sName;
     end;

   end;
   OnFormResize;
end;

procedure TRPGraphDayXL.SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
Var
    i : Integer;
Begin
        for i:=0 to sgGrid.RowCount-1 do Begin sgGrid.Cells[0,i+1] := IntToStr(i+1); sgGrid.RowHeights[i]:= nHigth;End;
End;
procedure TRPGraphDayXL.OnFormResize;
Var
    i : Integer;
Begin
    if FsgGrid=Nil then exit;
    for i:=1 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1));
End;

procedure TRPGraphDayXL.CreatReport(Date : TDateTime;CountTable:integer);
begin
   Page := 1;
   if FsgGrid.RowCount = 1 then
   begin
     exit;
   end;
   DateReport := Date;
   glCountTable := CountTable;
   try
   Excel := CreateOleObject('Excel.Application');
   except
       MessageDlg('На компьютере отсутствует MS Office Excell или не та версия', mtWarning, [mbOK], 0);
   end;

   FTID        := FDB.LoadTID(QRY_E30MIN_POW_EP + KindEnergy);
   if ItemInd = 0 then ItemInd := 1;
   Excel.Application.EnableEvents := false;
   Excel.WorkBooks.Add(ExtractFileDir(application.ExeName)+'\report\RPGraphDay.xlt.xls');
   Excel.ActiveSheet.PageSetup.Orientation:= 1;
   Sheet := Excel.Sheets.item[Page];
   Excel.ActiveWorkBook.worksheets[Page].activate;
   Sheet.Name := 'Грфаик мощности за ' + DateToStr(Date);
   frReport1ManualBuild;
end;

function TRPGraphDayXL.Replace(Str, X, Y: string): string;
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

Function  TRPGraphDayXL.FindAndReplace(find_,rep_:string):boolean;
 var range:variant;
begin
FindAndReplace:=false;
if find_<>'' then begin
   try
   range:=Excel.Range['A1:H59'].Replace(What:=find_,Replacement:=rep_);
   FindAndReplace:=true;
   except
   FindAndReplace:=false;
   end;
   end;
End;

procedure TRPGraphDayXL.FormTitle();
begin
   FindAndReplace('#Ndogovor&',Ndogovor);
   FindAndReplace('#WorksName&',WorksName);
   FindAndReplace('#NameObject&',NameObject);
   FindAndReplace('#Adress&',Adress);
   FindAndReplace('#MeterName&', FsgGrid.Cells[1, ItemInd]);
   FindAndReplace('#globalTitle&',globalTitle);
end;

procedure TRPGraphDayXL.FormTitle2();
begin
   FindAndReplace('#Ndogovor&',Ndogovor);
   FindAndReplace('#WorksName&',WorksName);
   FindAndReplace('#NameObject&',NameObject);
   FindAndReplace('#Adress&',Adress);
   FindAndReplace('#MeterName&', FsgGrid.Cells[1, ItemInd]);
   FindAndReplace('#globalTitle&',globalTitle);
end;

procedure TRPGraphDayXL.ShowData1;
var i : integer;
begin
   Page  := 3;
   Sheet := Excel.Sheets.item[Page];
   Excel.ActiveWorkBook.worksheets[Page].activate;
   for i := 0 to 47 do
   begin
     a_ := a_+ 1;
     Excel.ActiveSheet.Range['B'+IntToStr(a_)+':B'+IntToStr(a_)].Select;
     Excel.ActiveSheet.Range['B'+IntToStr(a_)+':B'+IntToStr(a_)].Merge;
     Excel.ActiveSheet.Cells[a_,2].Value := DVLS(Data.Items[0].v[i]*2);
   end;
   Page := 1;
   Sheet := Excel.Sheets.item[Page];
   Excel.ActiveWorkBook.worksheets[Page].activate;
end;

procedure TRPGraphDayXL.FindMaxAndSumTar;
var i      : integer;
    Index  : integer;
begin
   for i := 0 to 47 do
   begin
     Index := GetColorFromTariffs(i, m_pTariffs);
     if Data.Items[0].v[i]*2 > maxArray[Index] then
       maxArray[Index] := Data.Items[0].v[i]*2;
     Inc(numHalfHour[Index]);
     sumTarrif[Index] := sumTarrif[Index] + Data.Items[0].v[i];
   end;
end;

procedure TRPGraphDayXL.FillInfoPower();
begin
   FindMaxAndSumTar;
   FindAndReplace('#MidMaxP@', DVLS(maxArray[1]));
   FindAndReplace('#MidNightP@', DVLS(maxArray[4]/numHalfHour[4]));
   FindAndReplace('#MaxMorP@', DVLS(maxArray[1]));
   FindAndReplace('#MaxEvP@', DVLS(maxArray[2]));

   FindAndReplace('#RasxNE@', DVLS(sumTarrif[1]));
   FindAndReplace('#RasxPE@', DVLS(sumTarrif[4]));
   FindAndReplace('#RasxVNE@', DVLS(sumTarrif[2] + sumTarrif[3]));
end;

procedure TRPGraphDayXL.FillTitle;
begin
   FindAndReplace('#FirstSign@', FirstSign);
   FindAndReplace('#SecondSign@', SecondSign);
end;

procedure TRPGraphDayXL.FillReport(MID : integer);
var Year, Month, Day, i,r : word;
    param               : extended;

begin                                  
    FDB.GetTMTarPeriodsTable(StrToInt(FsgGrid.Cells[0, MID]), FTID{ + KindEnergy}, m_pTariffs);
    globalMeterName := 'Точка учета :' + FsgGrid.Cells[1, MID];
    MeterN          := 'Эл. сч. №' + FsgGrid.Cells[2, MID];
    AllMeter        :=  AllMeter + FsgGrid.Cells[1, MID] + ',';
    AllMeter        :=  replace(AllMeter,'  ', '');
    m_ID            :=  StrToInt(FsgGrid.Cells[0, MID]);
//    ShowHeader1;

    if not FDB.GetGraphDatas(DateReport, DateReport, StrToInt(FsgGrid.Cells[0, MID]),
                         QRY_SRES_ENR_EP, Data) then
    begin
      SetLength(Data.Items, 1);
      FillChar(Data.Items[0].v[0], 48, 0);
    end;
     ShowData1;
     // Page.ShowBandByName('MasterData1');
end;

procedure TRPGraphDayXL.frReport1ManualBuild();
var i,j                : integer;
    Month,Month1, Year,Year1, Day : word;
    TempDate         : TDateTime;
    pGT : SL3GROUPTAG;
begin
   for i := 1 to 4 do
   begin
     maxArray[i]    := 0;
     sumTarrif[i]   := 0;
     numHalfHour[i] := 0;
   end;
   FProgress.Create(Owner);
   FProgress.Visible := true;
   TempDate  := DateReport;
   DecodeDate(DateReport, Year, Month, Day);
   globalTitle := 'График мощности за ' + DateToStr(DateReport);
   glCountTableShow := 'Таблица № ' + IntToStr(glCountTable);
   FormTitle();
   FProgress.Max:= FsgGrid.RowCount;
   FillReport(ItemInd);
   IsLastPage := true;
   delete(AllMeter, length(AllMeter), 1);
   AllMeter := AllMeter + '.';
   FillInfoPower();
   FillTitle;
   //FindAndReplace('#MidDayP@','0');
  { Excel.ActiveWorkBook.WorkSheets[1].Range['A12:D'+IntToStr(a_)].Select;//выделяем всю таблицу
   Excel.Selection.Borders.LineStyle         :=1;//устанавливаем границы
 //  Excel.Selection.Borders.Weight           := xlMedium;
   Excel.Selection.HorizontalAlignment       :=-4108;
   Excel.Selection.WrapText:=true;
   Excel.ActiveSheet.PageSetup.PrintTitleRows:='$1:$11 ';// при печати на каждой странице ввыводится шапка
   Excel.ActiveSheet.PageSetup.LeftFooter :='&8'+FirstSign + SecondSign + ThirdSign;

   Page := Page + 1;
   Sheet := Excel.Sheets.item[Page];
   Excel.ActiveWorkBook.worksheets[Page].activate;
   Sheet.Name := 'Суммарный расход' + IntToStr(Page);
   FormTitle2;
   SetLength(AllMeter,(length(AllMeter)-1));
   Excel.ActiveSheet.Cells[8,1].Value := AllMeter;
   a_:= 11;
    for i := 0 to 3 do
     FillReportTtl(i);
   Excel.ActiveSheet.PageSetup.LeftFooter :='&8'+FirstSign + SecondSign + ThirdSign; }
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
      FProgress.Visible :=false;
      FProgress.Enabled  := false;
      FProgress := nil;
      //fm_nEVL.Free;
     end;
end;
end;
end.
