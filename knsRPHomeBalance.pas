unit knsRPHomeBalance;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FR_Class, BaseGrid, AdvGrid,
  utlconst, utltypes, utldatabase, utlTimeDate, utlbox, utlexparcer;

type
  TRPHomeBalanse = class(TForm)
    frReport: TfrReport;
    procedure frReportGetValue(const ParName: String; var ParValue: Variant);
    procedure frReportManualBuild(Page: TfrPage);
    procedure frReportEnterRect(Memo: TStringList; View: TfrView);
  private
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
    
    PH_DateBegin          : String[15];
    PH_DateEnd            : String[15];

    m_UseZeroTariff  : Boolean;
    m_VMID           : Integer;
    m_AbonentID      : Integer;
    m_ReportDate     : TDateTime;
    m_ReportSvDate   : TDateTime;
    m_Meters            : SL2TAGREPORTLIST;

    IsUsePokNow       : boolean;





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
    procedure SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
    procedure OnFormResize;
    procedure FillReport(MID : integer; var Page :TfrPage);
    procedure FillReportTtl(KindEN : byte; var Page : TfrPage);
    function  Replace(Str, X, Y: string): string;
    procedure FindValueFormula(tarif:integer;KindEn: byte;mid:string);
  public
    //SumEnergy
    procedure PrintPreview(Date : TDateTime);
    procedure PrepareTable;
  public
    m_strObjCode: string;

    bEnergMask  : byte;

    property Grid           : PTAdvStringGrid  read m_Grid     write m_Grid;
    property DatabaseLink   : PCDBDynamicConn  read m_DB       write m_DB;
    property Evaluator      : CEvaluator       read m_nEVL     write m_nEVL;

    property AbonenID       : Integer read m_AbonentID      write m_AbonentID;
    property AbonentName    : String  read PH_AbonentName    write PH_AbonentName;
    property AbonentAddress : String  read PH_AbonentAddress write PH_AbonentAddress;
    property Contract       : String  read PH_ContractNumber write PH_ContractNumber;
    property ObjectName     : String  read PH_ObjectName     write PH_ObjectName;
    property ObjectAddress  : String  read PH_ObjectAddress  write PH_ObjectAddress;
    property ObjectNumber   : String  read PH_ObjectNumber   write PH_ObjectNumber;
    property UseZeroTariff  : Boolean read m_UseZeroTariff  write m_UseZeroTariff;

    property prGroupID   :integer read GroupID write GroupID;


  end;

var
  f_RPRasxMonthV3: TRPHomeBalanse;
const
  c_EnergyTitles : array [0..3] of String = (
    'Активная принимаемая (кВт·ч)',
    'Активная выдаваемая (кВт·ч)',
    'Реактивная принимаемая (квар·ч)',
    'Реактивная выдаваемая (квар·ч)'
  );

implementation

{$R *.DFM}

procedure TRPHomeBalanse.SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
Var
    i : Integer;
Begin
        for i:=0 to sgGrid.RowCount-1 do Begin sgGrid.Cells[0,i+1] := IntToStr(i+1); sgGrid.RowHeights[i]:= nHigth;End;
End;

procedure TRPHomeBalanse.OnFormResize;
var
    i : Integer;
begin
    if m_Grid=nil then exit;
    for i:=1 to m_Grid.ColCount-1 do
      m_Grid.ColWidths[i] := trunc((m_Grid.Width-2*m_Grid.ColWidths[0])/(m_Grid.ColCount-1));
end;

procedure TRPHomeBalanse.PrepareTable;
var //m_Meters : SL2TAGREPORTLIST;
    i      : integer;
begin
   if m_Grid=Nil then exit;
   m_Grid.ColCount      := 5;
   m_Grid.RowCount      := 60;
   m_Grid.Cells[0,0]    := '№ п.п';
   m_Grid.Cells[1,0]    := 'Наименование учета';
   m_Grid.Cells[2,0]    := 'Номер счетчика';
   m_Grid.Cells[3,0]    := 'Коэффициент';
   m_Grid.Cells[4,0]    := 'Тип счетчика';
   m_Grid.ColWidths[0]  := 30;
   m_Grid.ColWidths[1]  := 200;
   m_Grid.FixedCols := 1;
   m_Grid.FixedRows := 1;
   SetHigthGrid(m_Grid^,20);
   if not m_DB.GetMeterGLVTableForReport(m_AbonentID,GroupID,0, m_Meters) then
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
     end;
   end;
   OnFormResize;
end;

procedure TRPHomeBalanse.PrintPreview(Date : TDateTime);
var
  l_Year, l_Month, l_Day : Word;
begin
  m_ReportDate   := Date;
  if (trim(PH_ContractNumber)<>'') then
    PH_ContractNumber := PH_ContractNumber;
  DecodeDate(m_ReportDate, l_Year, l_Month, l_Day);
  m_ReportSvDate := m_ReportDate;
  PH_ReportName := 'Отчет о показаниях счетчиков электроэнергии в ' + cDateTimeR.GetNameMonth(l_Month)+ ' ' + IntToStr(l_Year) + ' года';
  if m_Grid.RowCount > 1 then
    frReport.ShowReport();
end;

{glEnergMB
    glEnergME
    glEnergRazn
    glEnergRasx
    SumEnergy}

function TRPHomeBalanse.Replace(Str, X, Y: string): string;
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

procedure TRPHomeBalanse.FindValueFormula(tarif:integer;KindEn: byte;mid:string);
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



procedure TRPHomeBalanse.FillReport(MID : integer; var Page: TfrPage);
var Data                : CCDatas;
    KindEn              : byte;
    Year, Month, Day, i : word;
    TempDate            : TDateTime;
    param               : extended;
    l_IsFirstBandShowed,res : Boolean;
    nTypeID,swPLID,nMaxT: Integer;
begin
  l_IsFirstBandShowed := false;

  PH_CurrentMeterName   := 'Точка учета: ' + m_Grid.Cells[1, MID];
  PH_CurrentMeterNumber := 'Счетчик №' + m_Grid.Cells[2, MID];
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
    cDateTimeR.IncMonth(TempDate);
    for i := 1 to 4 do
    begin
      glEnergMB[i]   := 0;
      glEnergME[i]   := 0;
      glEnergRazn[i] := 0;
      glEnergRasx[i] := 0;
    end;

    if not IsUsePokNow then
    begin
      res := m_DB.GetGData(TempDate, TempDate, m_VMID, QRY_NAK_EN_MONTH_EP + KindEn, 0, Data);
      if res=False then
      res := m_DB.GetGData(TempDate, TempDate, m_VMID, QRY_NAK_EN_DAY_EP + KindEn, 0, Data);
      if not res then
      begin
        FindValueFormula(6,KindEn,m_Grid.Cells[0, MID]);
        if (not l_IsFirstBandShowed) then
        begin
          Page.ShowBandByName('MasterHeader1');
          l_IsFirstBandShowed := true;
        end else
          Page.ShowBandByName('MasterData1');
        continue;
      end;
    end
    else
    begin
      if not m_DB.GetCurrentDataInCCDatas(m_VMID, QRY_ENERGY_SUM_EP + KindEn, Data) then
      begin
        FindValueFormula(6,KindEn,m_Grid.Cells[0, MID]);
        if (not l_IsFirstBandShowed) then
        begin
          Page.ShowBandByName('MasterHeader1');
          l_IsFirstBandShowed := true;
        end else
          Page.ShowBandByName('MasterData1');
        continue;
      end
    end;

    for i := 0 to Data.Count - 1 do
    begin
      if (Data.Items[i].m_swTID <> 0) and (Data.Items[i].m_swTID <= nMaxT) then
      begin
        glEnergME[Data.Items[i].m_swTID] := RVLPr(Data.Items[i].m_sfValue/PH_CurrentMeterKE, MeterPrecision[m_VMID]);
        if (m_UseZeroTariff){ or (swPLID=1)} then                   //Суммирование по тарифам
          glEnergME[4] := glEnergME[4] + glEnergME[Data.Items[i].m_swTID];
      end
      else if (not m_UseZeroTariff) and (Data.Items[i].m_swTID = 0) then //Чтение нулевого тарифа из БД
        glEnergME[4] :=  RVLPr(Data.Items[i].m_sfValue/PH_CurrentMeterKE, MeterPrecision[m_VMID]);
    end;

    cDateTimeR.DecMonth(TempDate);

    res := m_DB.GetGData(TempDate, TempDate, m_VMID, QRY_NAK_EN_MONTH_EP + KindEn, 0, Data);
    if res=False then
    res := m_DB.GetGData(TempDate, TempDate, m_VMID, QRY_NAK_EN_DAY_EP + KindEn, 0, Data);
    if not res then
    begin
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
        glEnergMB[Data.Items[i].m_swTID] := RVLPr(Data.Items[i].m_sfValue/PH_CurrentMeterKE, MeterPrecision[m_VMID]);
        if (m_UseZeroTariff){ or (swPLID=1)} then
          glEnergMB[4] := glEnergMB[4] + glEnergMB[Data.Items[i].m_swTID];
      end
      else if (not m_UseZeroTariff) and (Data.Items[i].m_swTID = 0) then //Чтение нулевого тарифа из БД
        glEnergMB[4] := RVLPr(Data.Items[i].m_sfValue/PH_CurrentMeterKE, MeterPrecision[m_VMID]);
    end;

    for i := 1 to 4 do
    begin
      glEnergRazn[i] := glEnergME[i] - glEnergMB[i];
      glEnergRasx[i] := RVLPr(glEnergRazn[i], MeterPrecision[m_VMID])*PH_CurrentMeterKE;
      SumEnergy[KindEn][i] := SumEnergy[KindEn][i] + glEnergRasx[i];
      SumFormula[KindEn][i] := glEnergRasx[i];
      FindValueFormula(i,KindEn,m_Grid.Cells[0, MID]);
    end;
        if (not l_IsFirstBandShowed) then
        begin
          Page.ShowBandByName('MasterHeader1');
          l_IsFirstBandShowed := true;
        end else
          Page.ShowBandByName('MasterData1')
  end;
end;

procedure TRPHomeBalanse.FillReportTtl(KindEN : byte; var Page : TfrPage);
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


procedure TRPHomeBalanse.frReportManualBuild(Page: TfrPage);
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

   cDateTimeR.IncDate(m_ReportDate);
   PH_DateEnd := FormatDateTime('dd.mm.yyyy', m_ReportDate);
   cDateTimeR.DecMonth(m_ReportDate);
   PH_DateBegin := FormatDateTime('dd.mm.yyyy', m_ReportDate);
   
   IsUsePokNow := cDateTimeR.IsDateInMonthNow(m_ReportDate);
   if IsUsePokNow then
     PH_DateEnd := FormatDateTime('dd.mm.yyyy', Now());

   // отобразили шапку
   Page.ShowBandByType(btReportTitle);

   for i := 1 to m_Grid.RowCount - 1 do
     FillReport(i, Page);

   {if GroupID <> -1 then
   begin
     IsLastPage := true;
     Page.NewPage;
     delete(AllMeter, length(AllMeter), 1);
     AllMeter := AllMeter + '.';
     Page.ShowBandByName('MasterHeader2');
     for i := 0 to 3 do
       if (IsBitInMask(bEnergMask, i)) then
         FillReportTtl(i, Page);
   end; }
   Page.ShowBandByName('PageFooter1');
   //m_nEVL.Free;
end;

procedure TRPHomeBalanse.frReportGetValue(const ParName: String; var ParValue: Variant);
begin
   if      ParName = 'ContractNumber' then ParValue := PH_ContractNumber
   else if ParName = 'AbonentName'    then ParValue := PH_AbonentName
   else if ParName = 'AbonentAddress' then ParValue := PH_AbonentAddress
   else if ParName = 'ObjectNumber'     then ParValue := PH_ObjectNumber
   else if ParName = 'ObjectName'       then ParValue := PH_ObjectName
   else if ParName = 'ReportName'       then ParValue := PH_ReportName
   else if ParName = 'BeginDate'        then ParValue := PH_DateBegin
   else if ParName = 'EndDate'          then ParValue := PH_DateEnd

   else if ParName = 'CurrentMeterName'   then ParValue := PH_CurrentMeterName
   else if ParName = 'CurrentMeterNumber' then ParValue := PH_CurrentMeterNumber
   else if ParName = 'KTE'                then ParValue := FloatToStrF(PH_CurrentMeterKI, ffFixed, 18, 0)
                                                      +'·'+FloatToStrF(PH_CurrentMeterKU, ffFixed, 18, 0)
                                                      +'='+FloatToStrF(PH_CurrentMeterKE, ffFixed, 18, 0)
   else if ParName = 'KindEnergy'         then ParValue := PH_KindEnergy
   // значения
   else if ParName = 'EnerT1MB'   then ParValue := RVLPr(glEnergMB[1], MeterPrecision[m_VMID])
   else if ParName = 'EnerT2MB'   then ParValue := RVLPr(glEnergMB[2], MeterPrecision[m_VMID])
   else if ParName = 'EnerT3MB'   then ParValue := RVLPr(glEnergMB[3], MeterPrecision[m_VMID])
   else if ParName = 'EnerTsMB'   then ParValue := RVLPr(glEnergMB[4], MeterPrecision[m_VMID])
   else if ParName = 'EnerT1ME'   then ParValue := RVLPr(glEnergME[1], MeterPrecision[m_VMID])
   else if ParName = 'EnerT2ME'   then ParValue := RVLPr(glEnergME[2], MeterPrecision[m_VMID])
   else if ParName = 'EnerT3ME'   then ParValue := RVLPr(glEnergME[3], MeterPrecision[m_VMID])
   else if ParName = 'EnerTsME'   then ParValue := RVLPr(glEnergME[4], MeterPrecision[m_VMID])
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

procedure TRPHomeBalanse.frReportEnterRect(Memo: TStringList;
  View: TfrView);                                         
begin
   if IsLastPage then
     if (View.Name = 'Memo2') or (View.Name = 'Memo3') or (View.Name = 'Memo4') or
         (View.Name = 'Memo5') or (View.Name = 'Memo6') or (View.Name = 'Memo7') or
         (View.Name = 'Memo9') or (View.Name = 'Memo47') then
       View.Visible := false;
end;

end.
