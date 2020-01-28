unit knslRPLimitAndMaxPower;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Excel97,ComObj, OleServer ,BaseGrid, AdvGrid, utlconst, utltypes, utldatabase, utlTimeDate,
  utlbox,utlexparcer;

type
  TRPLimitAndMaxPower = class
  private
    { Private declarations }
    FDB               : PCDBDynamicConn;
    FABOID            : Integer;
    FsgGrid           : PTAdvStringGrid;
    Page              : integer;
    Excel             : variant;
    Sheet             : variant;
    exWorkBook        : Variant;
    FProgress         : PTProgressBar;
    posToWrite        : Integer;
    m_Tariffs         : TM_TARIFFS;
    m_TariffsNames    : array [0..3] of string;
    mTempMaxValues    : array [0..3] of double;
    mTimesOfMax       : array [0..3] of TDateTime;
    mMaxValues        : array of double;
    mLimits           : array of double;
    mTimes            : array of TDateTime;
    procedure BuildReport;
    procedure CalcValuesMEMax(Node: integer);
    procedure CalculateMaxValues(Node: integer);
    procedure ReadLimitValues(Node: integer);
    procedure CreateReportTitle;
    procedure CreateTarifTitle(Node: integer);
    procedure FillReport(Node, TID: integer);
    function  FindAndReplace(find,rep:string):boolean;
  public
    { Public declarations }
    WorksName         : string;
    FirstSign         : string;
    ThirdSign         : string;
    SecondSign        : string;
    NDogovor          : string;
    NameObject        : string;
    Adress            : string;
    m_strObjCode      : string;
    mAllowString      : string;
    m_KindEnergy      : Integer;
    dt_DateBeg        : TDateTime;
    dt_DateEnd        : TDateTime;
    procedure OnFormResize;
    procedure PrepareTable;
    procedure CreateReport;
    procedure SetExcelVisible;
    procedure CreateTariffsNames;
    function  GetColorFromTariffs(Srez:byte; var pTable:TM_TARIFFS):Byte;
    function  DateOutSec(Date : TDateTime) : string;
    procedure InitArrays;
    procedure SetColorToCell(Perc : double);
  public
    property PsgGrid     :PTAdvStringGrid  read FsgGrid      write FsgGrid;
    property PABOID      :Integer          read FABOID       write FABOID;
    property PDB         :PCDBDynamicConn  read FDB          write FDB;
    property PProgress   :PTProgressBar    read FProgress    write FProgress;
  end;

var
  RPLimitAndMaxPower : TRPLimitAndMaxPower;

implementation

procedure TRPLimitAndMaxPower.PrepareTable;
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

   if not FDB.GetMeterTableForReport(FABOID,-1,Meters) then
     FsgGrid.RowCount := 1
   else
   begin
     FsgGrid.RowCount := Meters.Count+1;
     for i := 0 to Meters.Count - 1 do
     begin
       if Meters.m_sMeter[i].m_sbyType = MET_VZLJOT then
         continue;
       FsgGrid.Cells[0,i+1] := IntToStr(Meters.m_sMeter[i].m_swVMID);
       if Meters.m_sMeter[i].m_sObject='Подразделения'  then  FsgGrid.Cells[1,i+1] := Meters.m_sMeter[i].m_sGroupName+' '+Meters.m_sMeter[i].m_sVMeterName else
       if Meters.m_sMeter[i].m_sObject<>'Подразделения' then  FsgGrid.Cells[1,i+1] := Meters.m_sMeter[i].m_sVMeterName;
       FsgGrid.Cells[2,i+1] := Meters.m_sMeter[i].m_sddPHAddres;
       FsgGrid.Cells[3,i+1] := DVLS(Meters.m_sMeter[i].m_sfKI*Meters.m_sMeter[i].m_sfKU);
       FsgGrid.Cells[4,i+1] := Meters.m_sMeter[i].m_sName;
     end;
   end;
   OnFormResize;
end;

procedure TRPLimitAndMaxPower.OnFormResize;
Var
    i : Integer;
Begin
    if FsgGrid=Nil then exit;
    for i:=1 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1));
    //PChild.OnFormResize;
End;

procedure TRPLimitAndMaxPower.CreateReport;
begin
   Page := 1;
   posToWrite := 1;
   try
   Excel := CreateOleObject('Excel.Application');
   except
     MessageDlg('На компьютере отсутствует MS Office Excel или не та версия', mtWarning, [mbOK], 0);
     exit;
   end;
   Excel.Application.EnableEvents := false;
   exWorkBook  := Excel.WorkBooks.Add(ExtractFileDir(application.ExeName)+'\report\RPMaxPowerLimit.xls');
   Excel.ActiveSheet.PageSetup.Orientation:= 1;
   Sheet      := Excel.Sheets.item[Page];
   Excel.ActiveWorkBook.worksheets[Page].activate;
   BuildReport;
end;

procedure TRPLimitAndMaxPower.BuildReport;
var i, j : integer;
    FTID : integer;
begin
   FProgress.Visible := true;

   FTID := FDB.LoadTID(QRY_E3MIN_POW_EP + m_KindEnergy);
   FDB.GetTMTarPeriodsTable(-1, FTID{ + KindEnergy}, m_Tariffs);
   CreateTariffsNames;
   FProgress.Max:=FsgGrid.RowCount + 4;
   FProgress.Position:=0;

   SetLength(mMaxValues, FsgGrid.RowCount * 4);
   SetLength(mLimits, FsgGrid.RowCount * 4);
   SetLength(mTimes, FsgGrid.RowCount * 4);
   InitArrays;

   for i := 1 to FsgGrid.RowCount - 1 do
   begin
     FProgress.Position := i;
     if (FsgGrid.Cells[0, i] <> '') then
     begin
       ReadLimitValues(i);
       CalculateMaxValues(i);
       //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
       CalcValuesMEMax(i);
     end;
   end;
   CreateReportTitle;

   //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
   for i := 0 to 0 do
   begin
     FProgress.Position := i + FsgGrid.RowCount;
     CreateTarifTitle(i);
     for j := 1 to FsgGrid.RowCount - 1 do
       if (FsgGrid.Cells[0, j] <> '') then
         FillReport(j, i);
   end;
   SetExcelVisible;
end;

procedure TRPLimitAndMaxPower.CalcValuesMEMax(Node: integer);
begin
   if mMaxValues[(Node - 1) * 4 + 0] < mMaxValues[(Node - 1) * 4 + 1] then
   begin
     mMaxValues[(Node - 1) * 4 + 0] := mMaxValues[(Node - 1) * 4 + 1];
     mTimes[(Node - 1) * 4 + 0] := mTimes[(Node - 1) * 4 + 1];
   end;
end;

procedure TRPLimitAndMaxPower.CalculateMaxValues(Node: integer);
var pTable : L3GRAPHDATAS;
    i, j   : integer;
    TID    : integer;
begin
   for i := 0 to 3 do
   begin
     mTempMaxValues[i] := 0;
     mTimesOfMax[i] := trunc(Now);
   end;
   PDB.GetGraphDatas(dt_DateEnd, dt_DateBeg, StrToInt(FsgGrid.Cells[0, Node]), QRY_SRES_ENR_EP + m_KindEnergy, pTable);
   for i := 0 to pTable.Count - 1 do
   begin
     for j := 0 to 47 do
     begin
       TID := GetColorFromTariffs(j, m_Tariffs) - 1;
       if (TID <= 3) and (TID >= 0) and (mTempMaxValues[TID] / 2 < pTable.Items[i].v[j]) then
       begin
         mTempMaxValues[TID] := pTable.Items[i].v[j] * 2;
         mTimesOfMax[TID] := trunc(pTable.Items[i].m_sdtDate) + EncodeTime (0, 30, 0, 0) * j;
       end;
     end;
   end;
   for i := 0 to 3 do
   begin
     mMaxValues[(Node - 1) * 4 + i] := mTempMaxValues[i];
     mTimes[(Node - 1) * 4 + i] := mTimesOfMax[i];
   end;
end;

procedure TRPLimitAndMaxPower.ReadLimitValues(Node: integer);
var LimTable : SL3LIMITTAGS;
    i, j     : integer;
begin
   PDB.GetLimitDatas(StrToInt(FsgGrid.Cells[0, Node]), QRY_E3MIN_POW_EP + m_KindEnergy, LimTable);
   for i := 1 to m_Tariffs.Count - 1 do
   begin
     if (m_Tariffs.Items[i].m_swTID > 4) or (m_Tariffs.Items[i].m_swTID <= 0) then
       break;
     mLimits[(Node - 1) * 4 + m_Tariffs.Items[i].m_swTID - 1] := 0;
     for j := 0 to LimTable.Count - 1 do
       if LimTable.Items[j].m_swTID = m_Tariffs.Items[i].m_swTID then
       begin
         mLimits[(Node - 1) * 4 + m_Tariffs.Items[i].m_swTID - 1] := LimTable.Items[j].m_swMaxValue;
         break;
       end;
   end;
end;

procedure TRPLimitAndMaxPower.CreateReportTitle;
begin
   Excel.ActiveSheet.Range['A' + IntToStr(posToWrite) + ':E' + IntToStr(posToWrite)].Select;
   Excel.Selection.Merge;
   Excel.ActiveSheet.Cells[posToWrite,1].Value := 'Максимумы за ' + DateToStr(dt_DateBeg) + ' - ' + DateToStr(dt_DateEnd);
   posToWrite := posToWrite + 1;
end;

procedure TRPLimitAndMaxPower.CreateTarifTitle(Node: integer);
begin

   posToWrite := posToWrite + 3;
   Excel.ActiveSheet.Range['A' + IntToStr(posToWrite) + ':E' + IntToStr(posToWrite)].Select;
   Excel.Selection.Merge;
   Excel.ActiveSheet.Cells[posToWrite,1].Value := 'Тарифная зона: ' + m_TariffsNames[Node];
   posToWrite := posToWrite + 1;
   Excel.ActiveSheet.Range['A' + IntToStr(posToWrite) + ':E' + IntToStr(posToWrite)].Select;
   Excel.Selection.Borders.LineStyle:=1;
   Excel.ActiveSheet.Cells[posToWrite,1].Value := 'Название т-ки у-та';
   Excel.ActiveSheet.Cells[posToWrite,2].Value := 'Время';
   Excel.ActiveSheet.Cells[posToWrite,3].Value := 'Значение';
   Excel.ActiveSheet.Cells[posToWrite,4].Value := '%';
   Excel.ActiveSheet.Cells[posToWrite,5].Value := 'Лимит';
   posToWrite := posToWrite + 1;
end;

procedure TRPLimitAndMaxPower.FillReport(Node, TID: integer);
var Position : integer;
    Perc     : double;
begin
   Position := (Node - 1) * 4 + TID;
   Excel.ActiveSheet.Range['A' + IntToStr(posToWrite) + ':E' + IntToStr(posToWrite)].Select;
   Excel.Selection.Borders.LineStyle:=1;
   Excel.ActiveSheet.Cells[posToWrite,1].Value := FsgGrid.Cells[1, Node];
   Excel.ActiveSheet.Cells[posToWrite,2].Value := DateToStr(mTimes[Position]) + ' ' + DateOutSec(mTimes[Position]) + '-' + DateOutSec(mTimes[Position] + EncodeTime(0, 30, 0, 0));
   Excel.ActiveSheet.Cells[posToWrite,3].Value := RVLPrStr(mMaxValues[Position], MeterPrecision[StrToInt(FsgGrid.Cells[0, Node])]);
   if mLimits[Position] <> 0 then
   begin
     Perc := mMaxValues[Position] / mLimits[Position];
     Excel.ActiveSheet.Cells[posToWrite,4].Value := RVLPrStr(Perc * 100, MeterPrecision[StrToInt(FsgGrid.Cells[0, Node])]);
   end
   else
   begin
     Perc := 1;
     Excel.ActiveSheet.Cells[posToWrite,4].Value := RVLPrStr(Perc * 100, MeterPrecision[StrToInt(FsgGrid.Cells[0, Node])]);
   end;
   Excel.ActiveSheet.Cells[posToWrite,5].Value := RVLPrStr(mLimits[Position], MeterPrecision[StrToInt(FsgGrid.Cells[0, Node])]);
   SetColorToCell(Perc);
   posToWrite := posToWrite + 1;
end;

function  TRPLimitAndMaxPower.FindAndReplace(find,rep:string):boolean;
var range : variant;
begin
   FindAndReplace := false;
   if find<>'' then
   begin
     try
       range:=Excel.Range['A1:EL230'].Replace(What := find,Replacement := rep);
       FindAndReplace:=true;
     except
       FindAndReplace:=false;
     end;
   end;
end;

procedure TRPLimitAndMaxPower.SetExcelVisible;
begin
   try
     Excel.Visible := true;
   finally
     if not VarIsEmpty(Excel) then
     begin
       //Excel.Quit;
       Excel := Unassigned;
       Sheet := Unassigned;
       exWorkBook:=Unassigned;
     end;
   end;
end;

procedure TRPLimitAndMaxPower.CreateTariffsNames;
var i : integer;
begin
  for i := 0 to 3 do
  begin
    m_TariffsNames[i] := '';
  end;
  for i := 1 to m_Tariffs.Count - 1 do
  begin
    if m_TariffsNames[m_Tariffs.Items[i].m_swTID-1] = '' then
      m_TariffsNames[m_Tariffs.Items[i].m_swTID-1] := m_Tariffs.Items[i].m_sName + '('
        + DateOutSec(m_Tariffs.Items[i].m_dtTime0) + ' - ' + DateOutSec(m_Tariffs.Items[i].m_dtTime1)
    else
      m_TariffsNames[m_Tariffs.Items[i].m_swTID-1] := m_TariffsNames[m_Tariffs.Items[i].m_swTID-1] + '; '
        + DateOutSec(m_Tariffs.Items[i].m_dtTime0) + ' - ' + DateOutSec(m_Tariffs.Items[i].m_dtTime1);
  end;
  for i := 0 to 3 do
    if m_TariffsNames[i] <> '' then
      m_TariffsNames[i] := m_TariffsNames[i] + ')'
    else
      m_TariffsNames[i] := 'Тариф не определен';
//!!!!!!!!!!!!!!!!!!!!!!
  m_TariffsNames[0] := 'Часы максимума';
//!!!!!!!!!!!!!!!!!!!!!!
end;

function TRPLimitAndMaxPower.GetColorFromTariffs(Srez:byte; var pTable:TM_TARIFFS):Byte;
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

function TRPLimitAndMaxPower.DateOutSec(Date : TDateTime) : string;
var str : string;
begin
   str := TimeToStr(Date);
   SetLength(str, Length(str) - 3);
   Result := str;
end;

procedure TRPLimitAndMaxPower.InitArrays;
var i : integer;
begin
   for i := 0 to Length(mMaxValues) - 1 do
   begin
     mMaxValues[i] := 0;
     mLimits[i] := 0;
     mTimes[i] := trunc(Now);
   end;
end;

procedure TRPLimitAndMaxPower.SetColorToCell(Perc : double);
begin
   Excel.ActiveSheet.Range['C' + IntToStr(posToWrite) + ':E' + IntToStr(posToWrite)].Select;
   if (Perc >= 0) and (Perc < 0.9) then
     Excel.Selection.Interior.ColorIndex := 10;//RGB(0, 255, 0);
   if (Perc >= 0.9) and (Perc < 1) then
     Excel.Selection.Interior.ColorIndex := 6;//RGB(0, 255, 255);
   if (Perc >= 1) then
     Excel.Selection.Interior.ColorIndex := 3;//RGB(255, 0, 0);
end;

end.
