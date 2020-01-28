unit knslRPBalanceDay;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FR_Class,BaseGrid, AdvGrid,
  utlconst, utltypes, utldatabase, utlTimeDate, utlbox, utlexparcer;

type
  TRPBalanseDay = class(TForm)
    frReport: TfrReport;
    procedure frReportEnterRect(Memo: TStringList; View: TfrView);
    procedure frReportGetValue(const ParName: String;
      var ParValue: Variant);
    procedure frReportManualBuild(Page: TfrPage);
  private
    { Private declarations }
    m_DB             : PCDBDynamicConn;
    m_Grid           : PTAdvStringGrid;
    m_nEVL           : CEvaluator;

    PH_ReportName     : String;
    PH_AbonentName    : String;
    PH_AbonentAddress : String;
    PH_ContractNumber : String;
    PH_ObjectNumber   : String;
    PH_ObjectName     : String;
    PH_ObjectAddress  : String;

    PH_CurrentMeterName   : String;
    PH_CurrentMeterNumber : String;
    PH_CurrentMeterKI,
    PH_CurrentMeterKU,
    PH_CurrentMeterKE     : Extended;

    PH_sumKvEnerT1MB      : String;
    PH_sumKvEnerT2MB      : String;
    PH_sumKvEnerT3MB      : String;
    PH_sumKvEnerTsMB      : String;
    PH_balKvEnerT1MB      : String;
    PH_balKvEnerT2MB      : String;
    PH_balKvEnerT3MB      : String;
    PH_balKvEnerTsMB      : String;
    PH_nebalKvEnerT1MB      : String;
    PH_nebalKvEnerT2MB      : String;
    PH_nebalKvEnerT3MB      : String;
    PH_nebalKvEnerTsMB      : String;

    db_sumKvEnerT1MB      : extended;
    db_sumKvEnerT2MB      : extended;
    db_sumKvEnerT3MB      : extended;
    db_sumKvEnerTsMB      : extended;
    db_balKvEnerT1MB      : extended;
    db_balKvEnerT2MB      : extended;
    db_balKvEnerT3MB      : extended;
    db_balKvEnerTsMB      : extended;
    db_nebalKvEnerT1MB    : extended;
    db_nebalKvEnerT2MB    : extended;
    db_nebalKvEnerT3MB    : extended;
    db_nebalKvEnerTsMB    : extended;

    PH_DateBegin          : String[15];
    PH_DateEnd            : String[15];

    PH_KVNumber           : String;

    m_UseZeroTariff  : Boolean;
    m_VMID           : Integer;
    m_AbonentID      : Integer;
    m_ReportDate     : TDateTime;
    m_ReportSvDate   : TDateTime;
    m_ReportDateEnd  : TDateTime;
    m_Meters         : SL2TAGREPORTLIST;
    
    IsUsePokNow       : boolean;

    glDateMB         : array [1..4] of TDateTime;
    glDateME         : array [1..4] of TDateTime;


    glEnergMB         : array [1..4] of extended;
    glEnergME         : array [1..4] of extended;
    glEnergRazn       : array [1..4] of extended;
    glEnergRasx       : array [1..4] of extended;
    PH_KindEnergy          : string;


    glSum             : array [1..4] of string;

    GroupID           : integer;
    SumEnergy         : array [0..3,1..4] of extended;
    AllMeter          : string;
    IsLastPage        : boolean;

    sExpr             : string;
    sExpr1            : array [0..3,1..4] of string;
    SumFormula        : array [0..3,1..4] of extended;
    m_blDataErr       : Boolean;
    m_blNoData       : Boolean;
    m_blNoDataE       : Boolean;

    procedure SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
    procedure OnFormResize;
    procedure FillReport(MID : integer; var Page :TfrPage);
    procedure FillReportTtl(KindEN : byte; var Page : TfrPage);
    function  Replace(Str, X, Y: string): string;
    procedure FindValueFormula(tarif:integer;KindEn: byte;mid:string);
  public
    procedure PrintPreview(Date : TDateTime);
    procedure PrepareTable;
  public
    m_strObjCode: string;
    dt_DateBeg        : TDateTime;
    dt_DateEnd        : TDateTime;
    bEnergMask  : byte;

    property Grid           : PTAdvStringGrid  read m_Grid     write m_Grid;
    property DatabaseLink   : PCDBDynamicConn  read m_DB       write m_DB;
    property Evaluator      : CEvaluator       read m_nEVL     write m_nEVL;

    property AbonenID       : Integer read m_AbonentID       write m_AbonentID;
    property AbonentName    : String  read PH_AbonentName    write PH_AbonentName;
    property AbonentAddress : String  read PH_AbonentAddress write PH_AbonentAddress;
    property Contract       : String  read PH_ContractNumber write PH_ContractNumber;
    property ObjectName     : String  read PH_ObjectName     write PH_ObjectName;
    property ObjectAddress  : String  read PH_ObjectAddress  write PH_ObjectAddress;
    property ObjectNumber   : String  read PH_ObjectNumber   write PH_ObjectNumber;
    property UseZeroTariff  : Boolean read m_UseZeroTariff   write m_UseZeroTariff;

    property prGroupID   :integer read GroupID write GroupID;


  end;

var
  rpBalanseDay: TRPBalanseDay;
  const
  c_EnergyTitles : array [0..3] of String = (
    'A+(кВт·ч)',
    'A-(кВт·ч)',
    'R+(кВа·ч)',
    'R-(кВа·ч)'
  );

implementation

{$R *.DFM}

procedure TRPBalanseDay.SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
Var
    i : Integer;
Begin
    for i:=0 to sgGrid.RowCount-1 do Begin sgGrid.Cells[0,i+1] := IntToStr(i+1); sgGrid.RowHeights[i]:= nHigth;End;
End;

procedure TRPBalanseDay.OnFormResize;
var
    i : Integer;
begin
    if m_Grid=nil then exit;
    for i:=1 to m_Grid.ColCount-1 do
      m_Grid.ColWidths[i] := trunc((m_Grid.Width-2*m_Grid.ColWidths[0])/(m_Grid.ColCount-1));
end;

procedure TRPBalanseDay.PrepareTable;
var //m_Meters : SL2TAGREPORTLIST;
    i      : integer;
begin
   if m_Grid=Nil then exit;
   m_Grid.ColCount      := 7;
   m_Grid.RowCount      := 60;
   m_Grid.Cells[0,0]    := '№ п.п';
   m_Grid.Cells[1,0]    := 'Наименование учета';
   m_Grid.Cells[2,0]    := 'Номер счетчика';
   m_Grid.Cells[3,0]    := 'Коэффициент';
   m_Grid.Cells[4,0]    := 'Тип счетчика';
   m_Grid.Cells[5,0]    := 'Тип учета';
   m_Grid.Cells[6,0]    := 'Индекс';
   m_Grid.ColWidths[0]  := 30;
   m_Grid.ColWidths[1]  := 200;
   m_Grid.FixedCols := 1;
   m_Grid.FixedRows := 1;
   //SetHigthGrid(m_Grid^,20);
   if not m_DB.GetMeterForHomeBallReport(m_AbonentID,GroupID,0, m_Meters) then
     m_Grid.RowCount := 1
   else
   begin
     m_Grid.RowCount := m_Meters.Count+1;
     for i := 0 to m_Meters.Count - 1 do
     begin
       m_Grid.Cells[0,i+1] := IntToStr(m_Meters.m_sMeter[i].m_swVMID);
       m_Grid.Cells[1,i+1] := m_Meters.m_sMeter[i].m_sVMeterName;
       m_Grid.Cells[2,i+1] := m_Meters.m_sMeter[i].m_sddPHAddres;
       m_Grid.Cells[3,i+1] := DVLS(m_Meters.m_sMeter[i].m_sfKI*m_Meters.m_sMeter[i].m_sfKU);
       m_Grid.Cells[4,i+1] := m_Meters.m_sMeter[i].m_sName;
       m_Grid.Cells[5,i+1] := m_nMeterLocation.Strings[m_Meters.m_sMeter[i].m_sbyLocation];
       m_Grid.Cells[6,i+1] := m_Meters.m_sMeter[i].m_sddKVNum;
     end;
   end;
   OnFormResize;
end;


procedure TRPBalanseDay.PrintPreview(Date : TDateTime);
var
  l_Year, l_Month, l_Day : Word;
begin
  m_ReportDate   := Date;
  if (trim(PH_ContractNumber)<>'') then
     PH_ContractNumber := PH_ContractNumber;
  DecodeDate(m_ReportDate, l_Year, l_Month, l_Day);
  m_ReportSvDate := m_ReportDate;
  PH_ReportName := 'Отчет о показаниях счетчиков электроэнергии на ' + IntToStr(l_Day)+ ' ' + cDateTimeR.GetNameMonth1(l_Month)+ ' ' + IntToStr(l_Year) + ' года';
  if m_Grid.RowCount > 1 then
     frReport.ShowReport();
end;

function TRPBalanseDay.Replace(Str, X, Y: string): string;
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


procedure TRPBalanseDay.FindValueFormula(tarif:integer;KindEn: byte;mid:string);
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

procedure TRPBalanseDay.FillReport(MID : integer; var Page: TfrPage);
var Data                : CCDatas;
    KindEn              : byte;
    Year, Month, Day, i : word;
    TempDate            : TDateTime;
    TempDate1           : String;
    param               : extended;
    l_IsFirstBandShowed,res : Boolean;
    nTypeID,swPLID,nMaxT: Integer;
    resT                : Boolean;
begin
  l_IsFirstBandShowed := false;


  //PH_CurrentMeterName   := 'Точка учета: ' + m_Grid.Cells[1, MID];
  //PH_CurrentMeterNumber := 'Счетчик №' + m_Grid.Cells[2, MID];
  PH_KVNumber           := m_Grid.Cells[6,MID];
  PH_CurrentMeterName   := m_Grid.Cells[1, MID];
  PH_CurrentMeterNumber := m_Grid.Cells[2, MID];
  PH_CurrentMeterKI     := m_Meters.m_sMeter[MID-1].m_sfKI;
  PH_CurrentMeterKU     := m_Meters.m_sMeter[MID-1].m_sfKU;
  PH_CurrentMeterKE     := PH_CurrentMeterKI*PH_CurrentMeterKU;

  AllMeter :=  AllMeter + m_Grid.Cells[1, MID] + ',';
  AllMeter := replace(AllMeter,'  ', '');
  m_VMID   := StrToInt(m_Grid.Cells[0, MID]);

    nMaxT  := 3;
    swPLID := 0;
    m_DB.GetMeterType(m_VMID,nTypeID,swPLID);
    if swPLID=1 then nMaxT:=2;

  m_ReportDate := m_ReportSvDate;
  TempDate := m_ReportDate;
  for KindEn := 0 to 3 do
  begin
    if not IsBitInMask(bEnergMask, KindEn) then
      continue;
    PH_KindEnergy := c_EnergyTitles[KindEn];
    TempDate := m_ReportDate;
    //cDateTimeR.DecDate(TempDate);
    for i := 1 to 4 do
    begin
      glEnergMB[i]   := 0;
      glEnergME[i]   := 0;
      glEnergRazn[i] := 0;
      glEnergRasx[i] := 0;
    end;
    resT := False;
    m_blDataErr:= False;
    m_blNoData := False;
    m_blNoDataE := False;

       cDateTimeR.DecDate(TempDate);   //предыдущий день
        res := m_DB.GetGData(TempDate, TempDate, m_VMID, QRY_NAK_EN_DAY_EP + KindEn, 0, Data);
          if not res then
           begin
           m_blDataErr:= True;
           m_blNoData := True;
           m_blNoDataE := True;
           FindValueFormula(6,KindEn,m_Grid.Cells[0, MID]);
            if (not l_IsFirstBandShowed) then
             begin
             Page.ShowBandByName('MasterHeader1');
             l_IsFirstBandShowed := true;
             end
            else
            Page.ShowBandByName('MasterData1');
            continue;
           end;

    for i := 0 to Data.Count - 1 do
    begin
      if (Data.Items[i].m_swTID <> 0) and (Data.Items[i].m_swTID <= nMaxT) then
      begin
        glDateMB[Data.Items[i].m_swTID] := Data.Items[i].m_sTime;
        glEnergMB[Data.Items[i].m_swTID] := RVLPr(Data.Items[i].m_sfValue/PH_CurrentMeterKE, MeterPrecision[m_VMID]);
        if (m_UseZeroTariff){ or (swPLID=1)} then                   //Суммирование по тарифам
          glEnergMB[4] := glEnergMB[4] + glEnergMB[Data.Items[i].m_swTID];
          if (glEnergMB[4]=0) then m_blDataErr:=True else m_blDataErr:=False;
      end
      else if (not m_UseZeroTariff) and (Data.Items[i].m_swTID = 0) then //Чтение нулевого тарифа из БД
        glEnergMB[4] :=  RVLPr(Data.Items[i].m_sfValue/PH_CurrentMeterKE, MeterPrecision[m_VMID]);

   end;

    cDateTimeR.IncDate(TempDate);   //текущий день
    m_blDataErr:= False;
    m_blNoData := False;
     //TempDate1:=FormatDateTime('dd.mm.yyyy', TempDate);
     // if (TempDate1<>FormatDateTime('dd.mm.yyyy',Date)) then
      // begin
    res := m_DB.GetGData(TempDate, TempDate, m_VMID, QRY_NAK_EN_DAY_EP + KindEn, 0, Data);
    if not res then
    begin
      m_blNoData := True;
      m_blDataErr:= True;
      FindValueFormula(6,KindEn,m_Grid.Cells[0, MID]);
        if (not l_IsFirstBandShowed) then
        begin
          Page.ShowBandByName('MasterHeader1');
          l_IsFirstBandShowed := true;
        end else
          Page.ShowBandByName('MasterData1');
      continue;
    end;

    for i := 0 to Data.Count - 1 do
    begin
      if (Data.Items[i].m_swTID <> 0) and (Data.Items[i].m_swTID <= nMaxT) then
      begin
        glDateME[Data.Items[i].m_swTID] := Data.Items[i].m_sTime;
        glEnergME[Data.Items[i].m_swTID] := RVLPr(Data.Items[i].m_sfValue/PH_CurrentMeterKE, MeterPrecision[m_VMID]);
        if (m_UseZeroTariff){ or (swPLID=1)} then
          glEnergME[4] := glEnergME[4] + glEnergME[Data.Items[i].m_swTID];
      end
      else if (not m_UseZeroTariff) and (Data.Items[i].m_swTID = 0) then //Чтение нулевого тарифа из БД
        glEnergME[4] := RVLPr(Data.Items[i].m_sfValue/PH_CurrentMeterKE, MeterPrecision[m_VMID]);
    end;
       
    m_blDataErr:=False;
    for i := 1 to 4 do
    begin
      glEnergRazn[i] := glEnergME[i] - glEnergMB[i];
      if (resT=True)and((glEnergRazn[i]<0)or(((Now-glDateME[i])>3)and(glDateME[i]<>0))) then m_blDataErr:=True;
      if (resT=False)and(glEnergRazn[i]<0) then m_blDataErr:=True;

      glEnergRasx[i] := RVLPr(glEnergRazn[i], MeterPrecision[m_VMID])*PH_CurrentMeterKE;
      SumEnergy[KindEn][i] := SumEnergy[KindEn][i] + glEnergRasx[i];
      SumFormula[KindEn][i] := glEnergRasx[i];
      FindValueFormula(i,KindEn,m_Grid.Cells[0, MID]);
    end;
    if (PH_KindEnergy='A+(кВт·ч)')and(m_Grid.Cells[5,MID]='КУ') then
    Begin
     db_sumKvEnerT1MB := db_sumKvEnerT1MB + glEnergRasx[1];
     db_sumKvEnerT2MB := db_sumKvEnerT2MB + glEnergRasx[2];
     db_sumKvEnerT3MB := db_sumKvEnerT3MB + glEnergRasx[3];
     db_sumKvEnerTsMB := db_sumKvEnerTsMB + glEnergRasx[4];
    End;
    if (PH_KindEnergy='A+(кВт·ч)')and(m_Grid.Cells[5,MID]='КУБ') then
    Begin
     db_balKvEnerT1MB := db_balKvEnerT1MB + glEnergRasx[1];
     db_balKvEnerT2MB := db_balKvEnerT2MB + glEnergRasx[2];
     db_balKvEnerT3MB := db_balKvEnerT3MB + glEnergRasx[3];
     db_balKvEnerTsMB := db_balKvEnerTsMB + glEnergRasx[4];
    End;
        if (not l_IsFirstBandShowed) then
        begin
          Page.ShowBandByName('MasterHeader1');
          l_IsFirstBandShowed := true;
        end else
          Page.ShowBandByName('MasterData1')
  end;
end;

procedure TRPBalanseDay.FillReportTtl(KindEN : byte; var Page : TfrPage);
var i : byte;
begin
  PH_KindEnergy := c_EnergyTitles[KindEN];
  //if GroupID=-1 then Begin Page.ShowBandByName('MasterData2');exit; End;
  for i := 1 to 4 do
   begin
   if  not((sExpr='[x]')or(sExpr='')) then
   begin
       m_nEVL.Expression :=  sExpr1[KindEn][i];  //формула
       if m_nEVL.Value < 0 then glSum[i] := 'Н/Д' else
       glSum[i] := FloatToStr(RVLPr(m_nEVL.Value, MaxPrecision));
   end
   else
   if SumEnergy[KindEn][i] < 0 then glSum[i] := 'Н/Д' else
   glSum[i] := FloatToStr(RVLPr(SumEnergy[KindEn][i], MaxPrecision));  {glSum[i] := DVLS(SumEnergy[KindEn][i]);}
   end;
   Page.ShowBandByName('MasterData2');
end;


procedure TRPBalanseDay.frReportEnterRect(Memo: TStringList;
  View: TfrView);
begin
  if IsLastPage then
     if (View.Name = 'Memo2') or (View.Name = 'Memo3') or (View.Name = 'Memo4') or
         (View.Name = 'Memo5') or (View.Name = 'Memo6') or (View.Name = 'Memo7') or
         (View.Name = 'Memo9') or (View.Name = 'Memo47') then
       View.Visible := false;
   if m_blDataErr=False then
   Begin
    if View.Name = 'Memo88'  then View.FillColor := clWhite;
    if View.Name = 'Memo76'  then View.FillColor := clWhite;   //$00FEFCD3; 211 252 254
    if View.Name = 'Memo77'  then View.FillColor := clWhite;
    if View.Name = 'Memo78'  then View.FillColor := clWhite;
    if View.Name = 'Memo79'  then View.FillColor := clWhite;
    if View.Name = 'Memo80'  then View.FillColor := clWhite;
    if View.Name = 'Memo83'  then View.FillColor := clWhite;
    if View.Name = 'Memo7'   then View.FillColor := clWhite;
    if View.Name = 'Memo82'  then View.FillColor := clWhite;
    if View.Name = 'Memo10'  then View.FillColor := clWhite;
    if View.Name = 'Memo11'  then View.FillColor := clWhite;
    if View.Name = 'Memo81'  then View.FillColor := clWhite;

    if View.Name = 'Memo31'  then View.FillColor := clWhite;
    if View.Name = 'Memo32'  then View.FillColor := clWhite;
    if View.Name = 'Memo47'  then View.FillColor := clWhite;
    if View.Name = 'Memo48'  then View.FillColor := clWhite;

    if View.Name = 'Memo52'  then View.FillColor := clWhite;
    if View.Name = 'Memo56'  then View.FillColor := clWhite;
    if View.Name = 'Memo60'  then View.FillColor := clWhite;
    if View.Name = 'Memo61'  then View.FillColor := clWhite;

    if View.Name = 'Memo63'  then View.FillColor := clWhite;
    if View.Name = 'Memo64'  then View.FillColor := clWhite;
    if View.Name = 'Memo65'  then View.FillColor := clWhite;
    if View.Name = 'Memo66'  then View.FillColor := clWhite;

    if View.Name = 'Memo67'  then View.FillColor := clWhite;
    if View.Name = 'Memo68'  then View.FillColor := clWhite;
    if View.Name = 'Memo69'  then View.FillColor := clWhite;
    if View.Name = 'Memo70'  then View.FillColor := clWhite;
   end else
   if (m_blDataErr=True) then
   Begin
    if View.Name = 'Memo76'  then View.FillColor := $008080ff;   //$00E1FFE1; 211 252 254
    if View.Name = 'Memo77'  then View.FillColor := $008080ff;
    if View.Name = 'Memo78'  then View.FillColor := $008080ff;
    if View.Name = 'Memo79'  then View.FillColor := $008080ff;
    if View.Name = 'Memo80'  then View.FillColor := $008080ff;
    if View.Name = 'Memo83'  then View.FillColor := $008080ff;

    if View.Name = 'Memo7'  then View.FillColor  := $008080ff;
    if View.Name = 'Memo82'  then View.FillColor := $008080ff;
    if View.Name = 'Memo10'  then View.FillColor := $008080ff;
    if View.Name = 'Memo11'  then View.FillColor := $008080ff;
    if View.Name = 'Memo81'  then View.FillColor := $008080ff;

    if View.Name = 'Memo31'  then View.FillColor := $008080ff;
    if View.Name = 'Memo32'  then View.FillColor := $008080ff;
    if View.Name = 'Memo47'  then View.FillColor := $008080ff;
    if View.Name = 'Memo48'  then View.FillColor := $008080ff;

    if View.Name = 'Memo52'  then View.FillColor := $008080ff;
    if View.Name = 'Memo56'  then View.FillColor := $008080ff;
    if View.Name = 'Memo60'  then View.FillColor := $008080ff;
    if View.Name = 'Memo61'  then View.FillColor := $008080ff;

    if View.Name = 'Memo63'  then View.FillColor := $008080ff;
    if View.Name = 'Memo64'  then View.FillColor := $008080ff;
    if View.Name = 'Memo65'  then View.FillColor := $008080ff;
    if View.Name = 'Memo66'  then View.FillColor := $008080ff;

    if View.Name = 'Memo67'  then View.FillColor := $008080ff;
    if View.Name = 'Memo68'  then View.FillColor := $008080ff;
    if View.Name = 'Memo69'  then View.FillColor := $008080ff;
    if View.Name = 'Memo70'  then View.FillColor := $008080ff;

   End;

end;


procedure TRPBalanseDay.frReportGetValue(const ParName: String; var ParValue: Variant);
begin
   if      ParName = 'ContractNumber' then ParValue := PH_ContractNumber
   else if ParName = 'KVNumber'       then ParValue := PH_KVNumber

   else if ParName = 'sumKvEnerT1MB'       then ParValue := RVLPr(db_sumKvEnerT1MB, MeterPrecision[m_VMID])
   else if ParName = 'sumKvEnerT2MB'       then ParValue := RVLPr(db_sumKvEnerT2MB, MeterPrecision[m_VMID])
   else if ParName = 'sumKvEnerT3MB'       then ParValue := RVLPr(db_sumKvEnerT3MB, MeterPrecision[m_VMID])
   else if ParName = 'sumKvEnerTsMB'       then ParValue := RVLPr(db_sumKvEnerTsMB, MeterPrecision[m_VMID])
   else if ParName = 'balEnerT1MB'       then ParValue := RVLPr(db_balKvEnerT1MB, MeterPrecision[m_VMID])
   else if ParName = 'balEnerT2MB'       then ParValue := RVLPr(db_balKvEnerT2MB, MeterPrecision[m_VMID])
   else if ParName = 'balEnerT3MB'       then ParValue := RVLPr(db_balKvEnerT3MB, MeterPrecision[m_VMID])
   else if ParName = 'balEnerTsMB'       then ParValue := RVLPr(db_balKvEnerTsMB, MeterPrecision[m_VMID])
   else if ParName = 'nebalEnerT1MB'     then ParValue := PH_nebalKvEnerT1MB
   else if ParName = 'nebalEnerT2MB'     then ParValue := PH_nebalKvEnerT2MB
   else if ParName = 'nebalEnerT3MB'     then ParValue := PH_nebalKvEnerT3MB
   else if ParName = 'nebalEnerTsMB'     then ParValue := PH_nebalKvEnerTsMB
   else if ParName = 'AbonentName'    then ParValue := PH_AbonentName
   else if ParName = 'AbonentAddress' then ParValue := PH_AbonentAddress
   else if ParName = 'ObjectNumber'   then ParValue := PH_ObjectNumber
   else if ParName = 'ObjectName'     then ParValue := PH_ObjectName
   else if ParName = 'ReportName'     then ParValue := PH_ReportName
   else if ParName = 'BeginDate'      then ParValue := PH_DateBegin
   else if ParName = 'EndDate'        then ParValue := PH_DateEnd

   else if ParName = 'CurrentMeterName'   then ParValue := PH_CurrentMeterName
   else if ParName = 'CurrentMeterNumber' then ParValue := PH_CurrentMeterNumber
   else if ParName = 'KTE'                then ParValue := FloatToStrF(PH_CurrentMeterKE, ffFixed, 18, 0)
                                          //then ParValue := FloatToStrF(PH_CurrentMeterKI, ffFixed, 18, 0)
                                          //            +'·'+FloatToStrF(PH_CurrentMeterKU, ffFixed, 18, 0)
                                          //            +'='+FloatToStrF(PH_CurrentMeterKE, ffFixed, 18, 0)
   else if ParName = 'KindEnergy'         then ParValue := PH_KindEnergy
   // значения
   else if ParName = 'EnerT1MB'   then Begin if m_blNoData=False then ParValue := RVLPr(glEnergMB[1], MeterPrecision[m_VMID]) else ParValue := 'Н/Д';End
   else if ParName = 'EnerT2MB'   then Begin if m_blNoData=False then ParValue := RVLPr(glEnergMB[2], MeterPrecision[m_VMID]) else ParValue := 'Н/Д';End
   else if ParName = 'EnerT3MB'   then Begin if m_blNoData=False then ParValue := RVLPr(glEnergMB[3], MeterPrecision[m_VMID]) else ParValue := 'Н/Д';End
   else if ParName = 'EnerTsMB'   then Begin if m_blNoData=False then ParValue := RVLPr(glEnergMB[4], MeterPrecision[m_VMID]) else ParValue := 'Н/Д';End
   else if ParName = 'EnerT1ME'   then Begin if m_blNoDataE=False then ParValue := RVLPr(glEnergME[1], MeterPrecision[m_VMID])else ParValue := 'Н/Д';End
   else if ParName = 'EnerT2ME'   then Begin if m_blNoDataE=False then ParValue := RVLPr(glEnergME[2], MeterPrecision[m_VMID])else ParValue := 'Н/Д';End
   else if ParName = 'EnerT3ME'   then Begin if m_blNoDataE=False then ParValue := RVLPr(glEnergME[3], MeterPrecision[m_VMID])else ParValue := 'Н/Д';End
   else if ParName = 'EnerTsME'   then Begin if m_blNoDataE=False then ParValue := RVLPr(glEnergME[4], MeterPrecision[m_VMID])else ParValue := 'Н/Д';End
   else if ParName = 'EnerT1Sub'  then ParValue := RVLPr(glEnergRazn[1], MeterPrecision[m_VMID])
   else if ParName = 'EnerT2Sub'  then ParValue := RVLPr(glEnergRazn[2], MeterPrecision[m_VMID])
   else if ParName = 'EnerT3Sub'  then ParValue := RVLPr(glEnergRazn[3], MeterPrecision[m_VMID])
   else if ParName = 'EnerTsSub'  then ParValue := RVLPr(glEnergRazn[4], MeterPrecision[m_VMID])
   else if ParName = 'EnerT1Rasx' then ParValue := RVLPr(glEnergRasx[1], MeterPrecision[m_VMID])
   else if ParName = 'EnerT2Rasx' then ParValue := RVLPr(glEnergRasx[2], MeterPrecision[m_VMID])
   else if ParName = 'EnerT3Rasx' then ParValue := RVLPr(glEnergRasx[3], MeterPrecision[m_VMID])
   else if ParName = 'EnerTsRasx' then ParValue := RVLPr(glEnergRasx[4], MeterPrecision[m_VMID])
   else if ParName = 'EnergT1Ttl' then ParValue := glSum[1]
   else if ParName = 'EnergT2Ttl' then ParValue := glSum[2]
   else if ParName = 'EnergT3Ttl' then ParValue := glSum[3]
   else if ParName = 'EnergTsTtl' then ParValue := glSum[4]
   else if ParName = 'KindEnTtl'  then ParValue := PH_KindEnergy
   else if ParName = 'AllMeter'   then ParValue := AllMeter;
end;



procedure TRPBalanseDay.frReportManualBuild(Page: TfrPage);
var i, j             : integer;
    Month,Month1, Year,Year1, Day : word;
    TempDate         : TDateTime;
    pGT : SL3GROUPTAG;
begin
 ////инициализация //формулы
 sExpr := m_pDB.GetMSGROUPEXPRESS(m_AbonentID,GroupID,pGT);
 if GroupID=-1 then //m_Meters : SL2TAGREPORTLIST;
 Begin
  sExpr := '';
  sExpr := 'v'+m_Grid.Cells[0, 1]+'_P';
  for i := 2 to m_Grid.RowCount - 1 do
    sExpr :=sExpr + ' + v'+m_Grid.Cells[0, i]+'_P';
 End;
 m_nEVL.Expression := sExpr;
 for i:=1 to 4 do
    for j:=0 to 3 do
       sExpr1[j][i] := sExpr;

   AllMeter :='';
   IsLastPage := false;
   for i := 0 to 3 do
     for j := 1 to 4 do
       SumEnergy[i][j] := 0;
   TempDate  := m_ReportDate;
   DecodeDate(m_ReportDate, Year, Month, Day);

   //cDateTimeR.IncDate(m_ReportDate);
   PH_DateEnd := FormatDateTime('dd.mm.yyyy', m_ReportDate);
   cDateTimeR.DecDate(m_ReportDate);
   PH_DateBegin := FormatDateTime('dd.mm.yyyy', m_ReportDate);
   // отобразили шапку
   Page.ShowBandByType(btReportTitle);


   db_sumKvEnerT1MB := 0;
   db_sumKvEnerT2MB := 0;
   db_sumKvEnerT3MB := 0;
   db_sumKvEnerTsMB := 0;
   db_balKvEnerT1MB := 0;
   db_balKvEnerT2MB := 0;
   db_balKvEnerT3MB := 0;
   db_balKvEnerTsMB := 0;

   if GroupID=-1 then
   Begin
    for i := 1 to m_Grid.RowCount - 1 do
    if (m_Grid.Cells[5,i]='КУ')or(m_Grid.Cells[5,i]='КУБ')or (m_Grid.Cells[5,i]='НКУНБ')then
    FillReport(i, Page);
   End else
   Begin
    for i := 1 to m_Grid.RowCount - 1 do
    FillReport(i, Page);
   End;

   PH_nebalKvEnerT1MB := 'Н/Д';
   PH_nebalKvEnerT2MB := 'Н/Д';
   PH_nebalKvEnerT3MB := 'Н/Д';
   PH_nebalKvEnerTsMB := 'Н/Д';
   if db_balKvEnerT1MB<>0 then PH_nebalKvEnerT1MB := FloatToStr(RVLPr(100*(db_sumKvEnerT1MB-db_balKvEnerT1MB)/db_balKvEnerT1MB,MeterPrecision[m_VMID]));
   if db_balKvEnerT2MB<>0 then PH_nebalKvEnerT2MB := FloatToStr(RVLPr(100*(db_sumKvEnerT2MB-db_balKvEnerT2MB)/db_balKvEnerT2MB,MeterPrecision[m_VMID]));
   if db_balKvEnerT3MB<>0 then PH_nebalKvEnerT3MB := FloatToStr(RVLPr(100*(db_sumKvEnerT3MB-db_balKvEnerT3MB)/db_balKvEnerT3MB,MeterPrecision[m_VMID]));
   if db_balKvEnerTsMB<>0 then PH_nebalKvEnerTsMB := FloatToStr(RVLPr(100*(db_sumKvEnerTsMB-db_balKvEnerTsMB)/db_balKvEnerTsMB,MeterPrecision[m_VMID]));
   Page.ShowBandByName('MasterHeader2');
   

   Page.ShowBandByName('PageFooter1');

end;

end.

