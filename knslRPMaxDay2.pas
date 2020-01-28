unit knslRPMaxDay2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FR_Class, BaseGrid, AdvGrid, utltypes, utldatabase, utlTimeDate, utlconst,
  FR_Desgn, utlbox, FR_E_CSV,utlexparcer;

type
  TRPMaxDaySlice = packed record
    m_HHID  : Byte;
    m_Value : Double;
    m_Color : TColor;
  end;

  TRPMaxDayRow = packed record
    m_State  : array[0..4] of Integer;
    m_Values : array[0..4] of TRPMaxDaySlice;
  end;
  
  TrpMaxDay2 = class(TForm)
    frReportMaxD: TfrReport;

    procedure frReportMaxDGetValue(const ParName: String; var ParValue: Variant);
    procedure frReportMaxDManualBuild(Page: TfrPage);
    procedure frReportMaxDEnterRect(Memo: TStringList; View: TfrView);
  private
    m_ReportDate      : TDateTime;
    m_Grid            : PTAdvStringGrid;
    m_Tariffs         : TM_TARIFFS;
    m_KindEnergy      : Integer;
    m_Maxes           : array[0..31] of TRPMaxDayRow;
    m_M               : array[0..4, 0..1] of Integer;
    m_CurrentRDay     : Integer;
    //m_Maxes          : array [0..3,0..31] of Double;

    VMeters           : SL3GROUPTAG;
    
    PH_ReportName : string;
    PH_MeterName  : string;

    PH_ShortDate      : String;
    PH_H_ResultMax    : String;
    PH_H_PMax5        : String;
    m_Precision       : Integer;

    PH_TariffNames    : array [0..3] of string;
    PH_MaxInterval    : array[0..4] of String;
    PH_MaxValue       : array[0..4] of String;
    
    globalTblDate     : string[15];
//    globalTblBegSlT   : array [0..3] of string[10];
//    globalTblEndSlT   : array [0..3] of string[10];
//    globalTblMaxSlT   : array [0..3] of string[15];
//    globalTblBegSlDay : string[15];
//    globalTblEndSlDay : string[15];
//    globalTblMaxSlDay : string[15];
//    globalTblMaxT     : array [0..3] of string[15];
//    globalTblMax      : string[15];
//    singTblMaxSlT     : array [0..3] of single;
    IsInitTar         : array [0..3,0..31] of boolean;
    SumMax            : array [0..3] of Double;
    ArraySumSlice     : array [0..31,0..47] of Double;
    singTblMaxSl      : Double;

    ItemInd           : Integer;
    FDB               : PCDBDynamicConn;
    FABOID            : Integer;
    m_Contract        : String;
    m_strZavNO        : String;
    //Fm_nEVL           : CEvaluator;
    GroupID           : integer;
    mTarMask          : array [1..4] of int64;

    function  GetColorFromTariffs(Srez:byte; var pTable:TM_TARIFFS):Byte;
    procedure FindMax(_Date : TDateTime);
    procedure FindSumMax(_Date : TDateTime);
    procedure FindMaxDay(_Date : TDateTime);

    procedure ReadMeterSlices(_Date : TDateTime);
    procedure ReadGroupSlices(_Date : TDateTime);
    procedure FillReport(_Date : TDateTime);
    procedure FillNull(_Date : TDateTime);
    
    procedure CreateTariffsNames();
    function  GetTariffAlias(_TariffName : String) : String;
  public
    IsRPGroup   : byte;
    KindEnergy  : byte;
    WorksName   : string;
    m_ReportColors   : array [0..2] of TColor;
    NDogovor    : string;
    NameObject  : string;
    Adress      : string;
    m_strObjCode: string;
    procedure OnFormResize;
    procedure PrepareTable;
    procedure PrepareTableSub;
    procedure PrintPreview(_Date : TDateTime; ItemIndMaxCtrl:Integer);
    function  FindNumOfGroups(var str: string):integer;
    function  GetGrStartPos(var str: string; stFP: integer):integer;
    procedure GetGrPos(var str:string; stFindPos:integer; var BP, EP : integer);
    function  GetGrStringArr(var str : string; maxSymbInStr : integer) : string;
  public
    property PsgGrid     :PTAdvStringGrid  read m_Grid      write m_Grid;
    property PDB         :PCDBDynamicConn  read FDB          write FDB;
    property PABOID      :Integer          read FABOID       write FABOID;
    property prGroupID   :integer          read GroupID      write GroupID;
    property Precision   : Integer        read m_Precision write m_Precision;
  end;

var
//  rpMaxDay    : TrpMaxDay2;
  rpMaxDay2   : TrpMaxDay2;
  //m_Grid   : ^TAdvStringGrid;
  IsFirstLoad : boolean = true;
const
  strEnergy   : array [0..3] of string = ('принимаемые активные',
                                          'отдаваемые активные',
                                          'принимаемые реактивные',
                                          'отдаваемые реактивные');

  strEnergyU  : array [0..3] of string = ('принимаемая активная',
                                          'отдаваемая активная',
                                          'принимаемая реактивная',
                                          'отдаваемая реактивная');
                                          
  strEK       : array [0..3] of string = ('кВт',
                                          'кВт',
                                          'квар',
                                          'квар');

const MAX_STR_CONFIG_LEN : integer = 100;
const strNewLine         : string  = #13;

implementation

{$R *.DFM}


procedure TrpMaxDay2.CreateTariffsNames();
var i : integer;
begin
  for i := 0 to 3 do
  begin
    PH_TariffNames[i] := '';
  end;
  for i := 1 to m_Tariffs.Count - 1 do
  begin
    if PH_TariffNames[m_Tariffs.Items[i].m_swTID-1] = '' then
      PH_TariffNames[m_Tariffs.Items[i].m_swTID-1] := GetTariffAlias(m_Tariffs.Items[i].m_sName) + #13#10
        + FormatDateTime('h:nn', m_Tariffs.Items[i].m_dtTime0) + '-' + FormatDateTime('h:nn', m_Tariffs.Items[i].m_dtTime1)
    else
      PH_TariffNames[m_Tariffs.Items[i].m_swTID-1] := PH_TariffNames[m_Tariffs.Items[i].m_swTID-1] + ', '
        + FormatDateTime('h:nn', m_Tariffs.Items[i].m_dtTime0) + '-' + FormatDateTime('h:nn', m_Tariffs.Items[i].m_dtTime1);
  end;
  for i := 0 to 3 do
    if PH_TariffNames[i] = '' then
      PH_TariffNames[i] := 'Тариф не определен';
end;

function TrpMaxDay2.GetColorFromTariffs(Srez:byte; var pTable:TM_TARIFFS):Byte;
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


procedure TrpMaxDay2.PrepareTable;
var Groups : SL3INITTAG;
    i      : integer;
begin
   if m_Grid=Nil then
     exit;
   m_Grid.ColCount   := 2;
   m_Grid.Cells[0,0] := '№ п.п';
   m_Grid.Cells[1,0] := 'Наименование группы';
   m_Grid.ColWidths[0]  := 30;

   if not FDB.GetAbonGroupsLVTable(FABOID,1,Groups) then
     m_Grid.RowCount := 1
   else
   begin
     m_Grid.RowCount := Groups.Count + 1;
     for i := 0 to Groups.Count - 1 do
     begin
       m_Grid.Cells[0, i + 1] := IntToStr(Groups.Items[i].m_sbyGroupID);
       m_Grid.Cells[1, i + 1] := Groups.Items[i].m_sGroupName;
     end;
   end;
   OnFormResize;
end;

procedure TrpMaxDay2.PrepareTableSub;
var Meters : SL2TAGREPORTLIST;
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

//   FDB.GetMetersAll(Meters)

   if not FDB.GetMeterGLVTableForReport(FABOID,-1,0, Meters) then
     m_Grid.RowCount := 1
   else
   begin
     m_Grid.RowCount := Meters.Count+1;
     for i := 0 to Meters.Count - 1 do
     begin
       if Meters.m_sMeter[i].m_sbyType = MET_VZLJOT then
         continue;
       m_Grid.Cells[0,i+1] := IntToStr(Meters.m_sMeter[i].m_swVMID);
       m_Grid.Cells[1,i+1] := Meters.m_sMeter[i].m_sVMeterName;
       m_Grid.Cells[2,i+1] := Meters.m_sMeter[i].m_sddPHAddres;
       m_Grid.Cells[3,i+1] := DVLS(Meters.m_sMeter[i].m_sfKI*Meters.m_sMeter[i].m_sfKU);
       m_Grid.Cells[4,i+1] := Meters.m_sMeter[i].m_sName;
     end;
   end;
   OnFormResize;
end;


procedure TrpMaxDay2.OnFormResize;
Var
    i : Integer;
Begin
    if m_Grid=Nil then exit;
    for i:=1 to m_Grid.ColCount-1  do m_Grid.ColWidths[i]  := trunc((m_Grid.Width-2*m_Grid.ColWidths[0])/(m_Grid.ColCount-1));
    //PChild.OnFormResize;
End;

procedure TrpMaxDay2.PrintPreview(_Date : TDateTime; ItemIndMaxCtrl:Integer);
begin
   IsFirstLoad := false;
   if m_Precision < 0 then
    m_Precision := 0;
   m_ReportDate  := _Date;
   if ItemIndMaxCtrl = 0 then
     ItemInd     := 1
   else
     ItemInd     := ItemIndMaxCtrl;
   m_KindEnergy  := FDB.LoadTID(QRY_E30MIN_POW_EP + KindEnergy);
   frReportMaxD.ShowReport;
end;

procedure TrpMaxDay2.frReportMaxDEnterRect(Memo: TStringList;
  View: TfrView);
begin
   if View.Name = 'Memo33' then
     View.FillColor := m_Maxes[m_CurrentRDay].m_Values[0].m_Color;//FillColorMaxDay[0];
   if View.Name = 'Memo36' then
     View.FillColor := m_Maxes[m_CurrentRDay].m_Values[1].m_Color;//FillColorMaxDay[1];
   if View.Name = 'Memo39' then
     View.FillColor := m_Maxes[m_CurrentRDay].m_Values[2].m_Color;//FillColorMaxDay[2];
   if View.Name = 'Memo42' then
     View.FillColor := m_Maxes[m_CurrentRDay].m_Values[3].m_Color;//FillColorMaxDay[3];
   if View.Name = 'Memo43' then
     View.FillColor := m_Maxes[m_CurrentRDay].m_Values[4].m_Color;//FillColorMaxDay[4];
   if View.Name = 'Memo50' then
     View.FillColor := m_ReportColors[2];
   if View.Name = 'Memo51' then
     View.FillColor := m_ReportColors[2];
   if View.Name = 'Memo52' then
     View.FillColor := m_ReportColors[2];
   if View.Name = 'Memo53' then
     View.FillColor := m_ReportColors[2];
   if View.Name = 'Memo54' then
     View.FillColor := m_ReportColors[2];

end;

procedure TrpMaxDay2.frReportMaxDGetValue(const ParName: String; var ParValue: Variant);
begin
   if ParName = 'KindEnU'     then ParValue := strEnergyU[KindEnergy];
   if ParName = 'TtlMaxPower' then ParValue := FloatToStrF(RVL(singTblMaxSl), ffFixed, 18, m_Precision) + ' ' + strEK[KindEnergy];
   if ParName = 'NDogovor'    then ParValue := m_Contract;
   if ParName = 'NameObject'  then ParValue := NameObject;
   if ParName = 'Adress'      then ParValue := Adress;
   if ParName = 'WorksName'   then ParValue := WorksName;
   if ParName = 'TtlMainName' then ParValue := PH_ReportName;
   if ParName = 'TtlNameTbl'  then ParValue := GetGrStringArr(PH_MeterName, MAX_STR_CONFIG_LEN)+m_strZavNO;
   if ParName = 'TblT1Name'   then ParValue := PH_TariffNames[0];
   if ParName = 'TblT2Name'   then ParValue := PH_TariffNames[1];
   if ParName = 'TblT3Name'   then ParValue := PH_TariffNames[2];
   if ParName = 'TblT4Name'   then ParValue := PH_TariffNames[3];
   if ParName = 'TblDate'     then ParValue := globalTblDate;

  // T1
  if (ParName = 'T1Interval') then
    if (m_Maxes[m_CurrentRDay].m_State[0] = 1) then
      ParValue := Format('%0.2d:%0.2d - %0.2d:%0.2d',
                [m_Maxes[m_CurrentRDay].m_Values[0].m_HHID div 2,
                (m_Maxes[m_CurrentRDay].m_Values[0].m_HHID mod 2)*30,
                (m_Maxes[m_CurrentRDay].m_Values[0].m_HHID+1) div 2,
               ((m_Maxes[m_CurrentRDay].m_Values[0].m_HHID+1) mod 2)*30])
    else ParValue := ' -- ';

  if ParName = 'TblMaxSlT1'  then
    if (m_Maxes[m_CurrentRDay].m_State[0] = 1) then
      ParValue := FloatToStrF(RVL(m_Maxes[m_CurrentRDay].m_Values[0].m_Value), ffFixed, 18, m_Precision)
    else ParValue := ' -- ';

  // T2
  if ParName = 'T2Interval'  then
    if (m_Maxes[m_CurrentRDay].m_State[1] = 1) then
      ParValue := Format('%0.2d:%0.2d - %0.2d:%0.2d',
                [m_Maxes[m_CurrentRDay].m_Values[1].m_HHID div 2,
                (m_Maxes[m_CurrentRDay].m_Values[1].m_HHID mod 2)*30,
                (m_Maxes[m_CurrentRDay].m_Values[1].m_HHID+1) div 2,
                ((m_Maxes[m_CurrentRDay].m_Values[1].m_HHID+1) mod 2)*30])
    else ParValue := ' -- ';

  if ParName = 'TblMaxSlT2'  then
    if (m_Maxes[m_CurrentRDay].m_State[1] = 1) then
      ParValue := FloatToStrF(RVL(m_Maxes[m_CurrentRDay].m_Values[1].m_Value), ffFixed, 18, m_Precision)
    else ParValue := ' -- ';

  // T3
  if ParName = 'T3Interval'  then
    if (m_Maxes[m_CurrentRDay].m_State[2] = 1) then
      ParValue := Format('%0.2d:%0.2d - %0.2d:%0.2d',
                [m_Maxes[m_CurrentRDay].m_Values[2].m_HHID div 2,
                (m_Maxes[m_CurrentRDay].m_Values[2].m_HHID mod 2)*30,
                (m_Maxes[m_CurrentRDay].m_Values[2].m_HHID+1) div 2,
                ((m_Maxes[m_CurrentRDay].m_Values[2].m_HHID+1) mod 2)*30])
    else ParValue := ' -- ';

  if ParName = 'TblMaxSlT3'  then
    if (m_Maxes[m_CurrentRDay].m_State[2] = 1) then
      ParValue := FloatToStrF(RVL(m_Maxes[m_CurrentRDay].m_Values[2].m_Value), ffFixed, 18, m_Precision)
    else ParValue := ' -- ';

  if ParName = 'T4Interval'  then
    if (m_Maxes[m_CurrentRDay].m_State[3] = 1) then
      ParValue := Format('%0.2d:%0.2d - %0.2d:%0.2d',
                [m_Maxes[m_CurrentRDay].m_Values[3].m_HHID div 2,
                (m_Maxes[m_CurrentRDay].m_Values[3].m_HHID mod 2)*30,
                (m_Maxes[m_CurrentRDay].m_Values[3].m_HHID+1) div 2,
                ((m_Maxes[m_CurrentRDay].m_Values[3].m_HHID+1) mod 2)*30])
    else ParValue := ' -- ';

  if ParName = 'TblMaxSlT4'  then
    if (m_Maxes[m_CurrentRDay].m_State[3] = 1) then
      ParValue := FloatToStrF(RVL(m_Maxes[m_CurrentRDay].m_Values[3].m_Value), ffFixed, 18, m_Precision)
    else ParValue := ' -- ';

  // T0
  if ParName = 'T0Interval' then
    if (m_Maxes[m_CurrentRDay].m_State[4] = 1) then
      ParValue := Format('%0.2d:%0.2d - %0.2d:%0.2d',
                [m_Maxes[m_CurrentRDay].m_Values[4].m_HHID div 2,
                (m_Maxes[m_CurrentRDay].m_Values[4].m_HHID mod 2)*30,
                (m_Maxes[m_CurrentRDay].m_Values[4].m_HHID+1) div 2,
                ((m_Maxes[m_CurrentRDay].m_Values[4].m_HHID+1) mod 2)*30])
    else ParValue := ' -- ';

  if ParName = 'TblMaxSlDay' then
    if (m_Maxes[m_CurrentRDay].m_State[4] = 1) then
      ParValue := FloatToStrF(RVL(m_Maxes[m_CurrentRDay].m_Values[4].m_Value), ffFixed, 18, m_Precision)
    else ParValue := ' -- ';

   if ParName = 'TblMaxT1'    then ParValue := DVLS(m_Maxes[31].m_Values[0].m_Value);
   if ParName = 'TblMaxT2'    then ParValue := DVLS(m_Maxes[31].m_Values[1].m_Value);
   if ParName = 'TblMaxT3'    then ParValue := DVLS(m_Maxes[31].m_Values[2].m_Value);
   if ParName = 'TblMaxT4'    then ParValue := DVLS(m_Maxes[31].m_Values[3].m_Value);
   if ParName = 'TblMaxDay'   then ParValue := DVLS(singTblMaxSl);

   if ParName = 'TblSumMaxT1'    then ParValue := FloatToStrF(SumMax[0], ffFixed, 18, m_Precision);
   if ParName = 'TblSumMaxT2'    then ParValue := FloatToStrF(SumMax[1], ffFixed, 18, m_Precision);
   if ParName = 'TblSumMaxT3'    then ParValue := FloatToStrF(SumMax[2], ffFixed, 18, m_Precision);
   if ParName = 'TblSumMaxT4'    then ParValue := FloatToStrF(SumMax[3], ffFixed, 18, m_Precision);

//   if ParName = 'KindEnergy'  then Parvalue := strEnergy[KindEnergy];
   if ParName = 'm_strObjCode'then Parvalue := m_strObjCode;
   if ParName = 'Pmax1'        then ParValue := 'Pмакс, ' + strEK[KindEnergy];
   if ParName = 'Pmax2'        then ParValue := 'Pмакс, ' + strEK[KindEnergy];
   if ParName = 'Pmax3'        then ParValue := 'Pмакс, ' + strEK[KindEnergy];
   if ParName = 'Pmax4'        then ParValue := 'Pмакс, ' + strEK[KindEnergy];
   if ParName = 'Pmax5'        then ParValue := PH_H_Pmax5;
   if ParName = 'PH_ShortDate' then ParValue := PH_ShortDate;
end;

procedure TrpMaxDay2.FindMax(_Date : TDateTime);
var
  l_Tariff, l_Day  : byte;
  Year, Month, Day : word;
begin
  DecodeDate(_Date, Year, Month, Day);
  singTblMaxSl := m_Maxes[0].m_Values[0].m_Value;

  for l_Tariff := 0 to 4 do
    for l_Day := 0 to cDateTimeR.DayPerMonth(Month, Year) - 1 do
    begin
      m_Maxes[l_Day].m_Values[l_Tariff].m_Value := m_Maxes[l_Day].m_Values[l_Tariff].m_Value;

      if (m_Maxes[l_Day].m_Values[l_Tariff].m_Value > singTblMaxSl) then
        singTblMaxSl :=  m_Maxes[l_Day].m_Values[l_Tariff].m_Value;
      {*
      if not IsInitTar[l_Tariff][31] then
      begin
        m_Maxes[31].m_Values[l_Tariff].m_Value  := m_Maxes[l_Day].m_Values[l_Tariff].m_Value;
        IsInitTar[l_Tariff][31] := true;
        m_Maxes[31].m_Values[l_Tariff].m_Color   := l_Tariff;
      end;
      *}
      if m_Maxes[l_Day].m_Values[l_Tariff].m_Value > m_Maxes[31].m_Values[l_Tariff].m_Value then
      begin
        m_Maxes[31].m_Values[l_Tariff].m_HHID := m_Maxes[l_Day].m_Values[l_Tariff].m_HHID;
        m_Maxes[31].m_Values[l_Tariff].m_Value := m_Maxes[l_Day].m_Values[l_Tariff].m_Value;
        m_Maxes[31].m_Values[l_Tariff].m_Color   := l_Tariff;
        m_M[l_Tariff][0] := l_Day;
        m_M[l_Tariff][1] := m_Maxes[l_Day].m_Values[l_Tariff].m_HHID;
      end;
    end;
end;




procedure TrpMaxDay2.FindSumMax(_Date : TDateTime);
var
  j             : byte;
  Year, Month, Day : word;
begin
  DecodeDate(_Date, Year, Month, Day);
  SumMax[0] := 0;
  SumMax[1] := 0;
  SumMax[2] := 0;
  SumMax[3] := 0;

  for j := 0 to cDateTimeR.DayPerMonth(Month, Year) - 1 do
  begin
    SumMax[0] := SumMax[0] + m_Maxes[j].m_Values[0].m_Value;
    SumMax[1] := SumMax[1] + m_Maxes[j].m_Values[1].m_Value;
    SumMax[2] := SumMax[2] + m_Maxes[j].m_Values[2].m_Value;
    SumMax[3] := SumMax[3] + m_Maxes[j].m_Values[3].m_Value;
  end;
end;


procedure TrpMaxDay2.FindMaxDay(_Date : TDateTime);
var Year, Month, Day : word;
    i                : byte;
    ColorInd         : word;
    param            : Double;
    l_HHID           : Integer;
begin
  DecodeDate(_Date, Year, Month, Day);
  Day          := Day - 1;
  ColorInd     := 0;
  param        := m_Maxes[Day].m_Values[0].m_Value;
  l_HHID       := m_Maxes[Day].m_Values[0].m_HHID;
  for i := 0 to 4 do
    m_Maxes[Day].m_Values[i].m_Color := m_ReportColors[0];
  for i := 1 to 3 do
    if m_Maxes[Day].m_Values[i].m_Value > param then
    begin
      param         := m_Maxes[Day].m_Values[i].m_Value;
      l_HHID        := m_Maxes[Day].m_Values[i].m_HHID;
      ColorInd      := i;
    end;
  if (m_Maxes[Day].m_Values[ColorInd].m_Color<>m_ReportColors[2]) then
    m_Maxes[Day].m_Values[ColorInd].m_Color := m_ReportColors[1];
  m_Maxes[Day].m_Values[4].m_HHID  := l_HHID;
  m_Maxes[Day].m_Values[4].m_Value := param;
  m_Maxes[Day].m_Values[4].m_Color := m_ReportColors[1];
end;

procedure TrpMaxDay2.FillNull(_Date : TDateTime);
//var i : byte;
begin
{
   globalTblDate     := DateToStr(_Date);
   globalTblMaxSlDay := '- - -';
   for i := 0 to 3 do
   begin
     globalTblBegSlT[i]   := ' - ';
     globalTblEndSlT[i]   := ' - ';
     globalTblMaxSlT[i]   := FloatToStrF(0, ffFixed, 18, m_Precision);
   end;
}
end;


procedure TrpMaxDay2.ReadGroupSlices(_Date : TDateTime);
var
    i, l_HHID, k     : word;
    Year, Month, Day : word;
    Index            : word;
    DateBeg, DateEnd : TDateTime;
    m_pGrData        : L3GRAPHDATAS;
begin
    //sExpr := m_pDB.GetMSGROUPEXPRESS(FABOID,GroupID,pGT);
    ZeroMemory(@ArraySumSlice, sizeof(ArraySumSlice));
    DecodeDate(_Date, Year, Month, Day);
    Day := 1;
    DateBeg := EncodeDate(Year, Month, Day);
    Day := cDateTimeR.DayPerMonth(Month, Year);
    DateEnd := EncodeDate(Year, Month, Day);

   for i := 0 to VMeters.m_swAmVMeter - 1 do
   begin
     //if VMeters.Item.Items[i].m_sbyType = MET_SUMM then
     //  continue;
     if not FDB.GetGraphDatas(DateEnd, DateBeg, VMeters.Item.Items[i].m_swVMID,
                                QRY_SRES_ENR_EP + KindEnergy, m_pGrData) then
       continue
     else
       for k := 0 to m_pGrData.Count - 1 do
       begin
         DecodeDate(m_pGrData.Items[k].m_sdtDate, Year, Month, Day);
         Dec(Day);

         for l_HHID := 0 to 47 do
         begin
           if not (IsBitInMask(m_pGrData.Items[k].m_sMaskReRead, l_HHID)) then
             continue;
           ArraySumSlice[Day, l_HHID] := ArraySumSlice[Day, l_HHID] + m_pGrData.Items[k].v[l_HHID]*2;
           Index := GetColorFromTariffs(l_HHID, m_Tariffs) - 1;
           m_Maxes[Day].m_State[Index] := 1;
           m_Maxes[Day].m_State[4] := 1;
           IsInitTar[Index][Day] := true;
         end;
       end;
   end;
  for Day := 0 to cDateTimeR.DayPerMonth(Month, Year) do
  begin
    for l_HHID := 0 to 47 do
    begin
      Index := GetColorFromTariffs(l_HHID, m_Tariffs) - 1;
      {*
      if not IsInitTar[Index, Day] then
      begin
        m_Maxes[Day].m_Values[Index].m_Value  := ArraySumSlice[Day,l_HHID];
        m_Maxes[Day].m_Values[Index].m_HHID    := l_HHID;
      end;
      *}
      if ArraySumSlice[Day, l_HHID] > m_Maxes[Day].m_Values[Index].m_Value then
      begin
        m_Maxes[Day].m_Values[Index].m_Value := ArraySumSlice[Day,l_HHID];
        m_Maxes[Day].m_Values[Index].m_HHID   := l_HHID;
      end;

      if ArraySumSlice[Day, l_HHID] > m_Maxes[Day].m_Values[4].m_Value then
      begin
        m_Maxes[Day].m_Values[4].m_Value := ArraySumSlice[Day,l_HHID];
        m_Maxes[Day].m_Values[4].m_HHID   := l_HHID;
      end;
    end;
  end;
end;

procedure TrpMaxDay2.ReadMeterSlices(_Date : TDateTime);
var
    l_HH, l_SliceRow       : word;
    l_Year, l_Month, l_Day : word;
    l_TariffID             : word;
    i                      : integer;
    DateBeg, DateEnd : TDateTime;
    m_pGrData         : L3GRAPHDATAS;
begin

    FDB.GetTMTarPeriodsCmdTable(_Date,StrToInt(m_Grid.Cells[0, ItemInd]),QRY_SRES_ENR_EP + KindEnergy,4,m_Tariffs);

    //FDB.GetTMTarPeriodsTable(StrToInt(m_Grid.Cells[0, ItemInd]), m_KindEnergy{ + KindEnergy}, m_Tariffs);
  for i := 1 to 4 do
    mTarMask[i] := GetTAllMask(i, m_Tariffs);

  DecodeDate(_Date, l_Year, l_Month, l_Day);
  l_Day := 1;
  DateBeg := EncodeDate(l_Year, l_Month, l_Day);
  l_Day := cDateTimeR.DayPerMonth(l_Month, l_Year);
  DateEnd := EncodeDate(l_Year, l_Month, l_Day);
  if not FDB.GetGraphDatas(DateEnd, DateBeg, StrToInt(m_Grid.Cells[0, ItemInd]),
                           QRY_SRES_ENR_EP + KindEnergy, m_pGrData) then
    exit
  else
    for l_SliceRow := 0 to m_pGrData.Count - 1 do
    begin
      DecodeDate(m_pGrData.Items[l_SliceRow].m_sdtDate, l_Year, l_Month, l_Day);
      Dec(l_Day);
      for l_HH := 0 to 47 do
      begin
         if not (IsBitInMask(m_pGrData.Items[l_SliceRow].m_sMaskReRead, l_HH)) then
           continue;
         l_TariffID := GetColorFromTariffs(l_HH, m_Tariffs) - 1;
         m_Maxes[l_Day].m_State[l_TariffID] := 1;
         m_Maxes[l_Day].m_State[4] := 1;
         {
         if not IsInitTar[l_TariffID, l_Day] then
         begin
           m_Maxes[l_Day].m_Values[l_TariffID].m_Value  := m_pGrData.Items[l_SliceRow].v[l_HH];
           IsInitTar[l_TariffID][l_Day] := true;
           m_Maxes[l_Day].m_Values[l_TariffID].m_HHID := l_HH;
         end;
         }
         if m_pGrData.Items[l_SliceRow].v[l_HH]*2 > m_Maxes[l_Day].m_Values[l_TariffID].m_Value then
         begin
           m_Maxes[l_Day].m_Values[l_TariffID].m_Value := m_pGrData.Items[l_SliceRow].v[l_HH]*2;
           m_Maxes[l_Day].m_Values[l_TariffID].m_HHID  := l_HH;
         end;

        if m_pGrData.Items[l_SliceRow].v[l_HH]*2 > m_Maxes[l_Day].m_Values[4].m_Value then
        begin
           m_Maxes[l_Day].m_Values[4].m_Value := m_pGrData.Items[l_SliceRow].v[l_HH]*2;
           m_Maxes[l_Day].m_Values[4].m_HHID  := l_HH;
        end;
      end;
    end;
end;


procedure TrpMaxDay2.FillReport(_Date : TDateTime);
var Year, Month, Day : word;
    i                : byte;
begin
   FindMaxDay(_Date);

  m_Maxes[m_M[0][0]].m_Values[0].m_Color := m_ReportColors[2];
  m_Maxes[m_M[1][0]].m_Values[1].m_Color := m_ReportColors[2];
  m_Maxes[m_M[2][0]].m_Values[2].m_Color := m_ReportColors[2];
  m_Maxes[m_M[3][0]].m_Values[3].m_Color := m_ReportColors[2];
  m_Maxes[m_M[4][0]].m_Values[4].m_Color := m_ReportColors[2];
  
   DecodeDate(_Date, Year, Month, Day);
   Day := Day - 1;
   globalTblDate     := DateToStr(_Date);

   for i:= 0 to 4 do
   begin
     if (m_Maxes[m_CurrentRDay].m_State[i] <> 1) then
     begin
       PH_MaxInterval[i] := '--';
       PH_MaxValue[i]    := '--';
     end
     else
     begin
       PH_MaxInterval[i] := Format('%0.2d:%0.2d - %0.2d:%0.2d', [
           m_Maxes[m_CurrentRDay].m_Values[i].m_HHID div 2,
           (m_Maxes[m_CurrentRDay].m_Values[i].m_HHID mod 2)*30,
           (m_Maxes[m_CurrentRDay].m_Values[i].m_HHID+1) div 2,
           ((m_Maxes[m_CurrentRDay].m_Values[i].m_HHID+1) mod 2)*30
         ]);
        PH_MaxValue[i]    := FloatToStrF(RVL(m_Maxes[m_CurrentRDay].m_Values[i].m_Value), ffFixed, 18, m_Precision);
     end;
   end;

   if not((IsInitTar[0][Day]) or (IsInitTar[1][Day]) or (IsInitTar[2][Day]) or (IsInitTar[3][Day])) then
   begin     //Если тарифы не проиницилизированны
     FillNull(_Date);
     exit;
   end;{
   for i := 0 to 3 do
   begin
    l_HHID := m_Maxes[Day].m_Values[i].m_HHID;
    m_Maxes[Day].m_Values[i].m_HHID := l_HHID;
    Inc(l_HHID);
//    globalTblEndSlT[i] := Format('%0.2d:%0.2d',[l_HHID div 2, (l_HHID mod 2)*30]);
//    globalTblMaxSlT[i] := FloatToStrF(m_Maxes[Day].m_Values[i].m_Value, ffFixed, 18, m_Precision);
    if m_Maxes[31].m_Values[i].m_HHID <> Day then
    begin
      if FillColorMaxDay[i] <> m_ReportColors[1] then
         FillColorMaxDay[i] := m_ReportColors[0];
    end
    else
      FillColorMaxDay[i] := m_ReportColors[2];

   end;}
end;

procedure TrpMaxDay2.frReportMaxDManualBuild(Page: TfrPage);
var
  Year, Month, Day : word;
  i,j              : integer;
  TempDate         : TDateTime;
begin
   for i := 0 to 3 do
     for j := 0 to 31 do
     begin
       m_Maxes[j].m_Values[i].m_HHID := 0;
       m_Maxes[j].m_Values[i].m_Value := 0;
       m_Maxes[j].m_Values[i].m_Color := 0;
       m_Maxes[j].m_State[i] := 0;
       m_Maxes[j].m_State[4] := 0;
       IsInitTar[i, j] := false;
     end;
  NDogovor := trim(NDogovor);
  if (NDogovor <> '') then
    m_Contract := NDogovor;
   FillChar(ArraySumSlice, sizeof(ArraySumSlice), 0);


   //FDB.GetTMTarPeriodsTable(-1, m_KindEnergy{ + KindEnergy}, m_Tariffs);

    //FDB.GetVMetersTable(FABOID,StrToInt(m_Grid.Cells[0, ItemInd]), VMeters);
    //FDB.GetTMTarPeriodsCmdTable(m_ReportDate,VMeters.Item.Items[0].m_swVMID,QRY_SRES_ENR_EP + KindEnergy,4,m_Tariffs);

   if IsRPGroup = 0 then
   Begin
    FDB.GetVMetersTable(FABOID,StrToInt(m_Grid.Cells[0, ItemInd]), VMeters);
    FDB.GetTMTarPeriodsCmdTable(m_ReportDate,VMeters.Item.Items[0].m_swVMID,QRY_SRES_ENR_EP + KindEnergy,4,m_Tariffs);
    m_strZavNO := '';
   End;
   if IsRPGroup = 1 then
   Begin
    FDB.GetTMTarPeriodsCmdTable(m_ReportDate,StrToInt(m_Grid.Cells[0, ItemInd]),QRY_SRES_ENR_EP + KindEnergy,4,m_Tariffs);
    m_strZavNO := ' №'+m_Grid.Cells[2, ItemInd];
   End;



   for i := 1 to 4 do
     mTarMask[i] := GetTAllMask(i, m_Tariffs);
     
   DecodeDate(m_ReportDate, Year, Month, Day);
   //PH_ReportName := 'Наибольшие совмещенные получасовые максимумы мощности в ' + cDateTimeR.GetNameMonth(Month)
   //                      + ' ' + IntToStr(Year) + ' года' + ' в часы максимальных нагрузок энергосистемы ';
   PH_ShortDate := cDateTimeR.GetNameMonth(Month)+ ' ' + IntToStr(Year) + ' года';
    PH_MeterName  := m_Grid.Cells[1, ItemInd];

    if IsRPGroup = 0 then
      PH_ReportName := 'Наибольшие совмещенные получасовые ' + strEnergy[KindEnergy] +' мощности в ' + PH_ShortDate
    else
      PH_ReportName := 'Наибольшие получасовые ' + strEnergy[KindEnergy] +' мощности в ' + PH_ShortDate;

   if (KindEnergy = 0) or (KindEnergy = 1) then
   begin
    if (m_Tariffs.Count>=3)and(m_Tariffs.Count<=4) then
    PH_H_ResultMax := FormatDateTime('h:nn', m_Tariffs.Items[2].m_dtTime0) + '-' + FormatDateTime('h:nn', m_Tariffs.Items[2].m_dtTime1) +
                         ', ' +FormatDateTime('h:nn', m_Tariffs.Items[1].m_dtTime0) + '-' + FormatDateTime('h:nn', m_Tariffs.Items[1].m_dtTime1)else
    if m_Tariffs.Count>=7 then
    PH_H_ResultMax := FormatDateTime('h:nn', m_Tariffs.Items[5].m_dtTime0) + '-' + FormatDateTime('h:nn', m_Tariffs.Items[5].m_dtTime1) +
                         ', ' +FormatDateTime('h:nn', m_Tariffs.Items[6].m_dtTime0) + '-' + FormatDateTime('h:nn', m_Tariffs.Items[6].m_dtTime1);

    PH_H_PMax5 := 'Наибольшие мощности ' + #13#10 + 'за сутки' + #13#10 + '00:00-24:00';
   end
   else
   begin
      PH_H_ResultMax := '';
//      PH_H_PMax5 := 'Наибольшие мощности в дневные и ночные часы';
   end;

   CreateTariffsNames();

//   Page.ShowBandByName('PageHeader1');
   Day      := 1;
   TempDate := EncodeDate(Year, Month, Day);

   FDB.GetVMetersTable(FABOID,StrToInt(m_Grid.Cells[0, ItemInd]), VMeters);
   GroupID := StrToInt(m_Grid.Cells[0, ItemInd]);
   Begin

  if IsRPGroup = 0 then
    ReadGroupSlices(m_ReportDate)
  else if IsRPGroup = 1 then
    ReadMeterSlices(m_ReportDate);

  TempDate := EncodeDate(Year, Month, Day);
  FindMax(TempDate);
  m_CurrentRDay := 0; 
   while cDateTimeR.CompareMonth(TempDate, m_ReportDate) = 0 do
   begin
     FillReport(TempDate);
     Page.ShowBandByName('MasterData1');
     cDateTimeR.IncDate(TempDate);
     Inc(m_CurrentRDay);
   end;

   Page.ShowBandByName('MasterData2');
   FindSumMax(TempDate);
   Page.ShowBandByName('SumMax');
   Page.ShowBandByName('PageFooter1');
   //m_Grid := nil;
   End;
end;

function TrpMaxDay2.GetTariffAlias(_TariffName : String) : String;
begin
  if (_TariffName = 'Утренний максимум') then
    Result := 'Утренние часы (максимальных нагрузок энергосистемы)'
  else if (_TariffName = 'Вечерний максимум') then
    Result := 'Вечерние часы (максимальных нагрузок энергосистемы)'
  else if (_TariffName = 'Дневная зона') then
    Result := 'Дневные часы (средних нагрузок энергосистемы)'
  else if (_TariffName = 'Ночная зона') then
    Result := 'Ночные часы (минимальных нагрузок энергосистемы)'
  else
    Result := _TariffName;
end;

function TrpMaxDay2.FindNumOfGroups(var str: string):integer;
var i, j : integer;
begin
   Result := 1;
   for i := 1 to Length(str) do
   begin
     if (str[i] = '+') or (str[i] = '-') then
       for j := i + 1 to i + 5 do
         if (str[j] = 'Г') and (str[j + 1] = 'р') then
         begin
           Result := Result + 1;
           break;
         end;
   end;
end;

function TrpMaxDay2.GetGrStartPos(var str: string; stFP: integer):integer;
var i, j : integer;
begin
   Result := Length(str);
   for i := stFP to Length(str) do
   begin
     if (str[i] = '+') or (str[i] = '-') then
       for j := i + 1 to i + 5 do
         if (str[j] = 'Г') and (str[j + 1] = 'р') then
         begin
            Result := j - 1;
            exit;
         end;
   end;
end;

procedure TrpMaxDay2.GetGrPos(var str:string; stFindPos:integer; var BP, EP : integer);
begin
   BP := 0;
   EP := 0;
   BP := GetGrStartPos(str, stFindPos);
   EP := GetGrStartPos(str, BP);
end;

function TrpMaxDay2.GetGrStringArr(var str : string; maxSymbInStr : integer) : string;
var nCount, tLen    : integer;
    strArr          : array of string;
    i,stP, eP, iP   : integer;
begin
   Result := '';
   iP     := 1;

   nCount := FindNumOfGroups(str);
   SetLength(strArr, nCount);

   for i := 0 to nCount - 1 do
   begin
      GetGrPos(str, iP, stP, eP);
      strArr[i] := Copy(str, iP, stP - iP + 1);
      iP := stP + 1;
   end;

   Result := strArr[0];
   tLen   := Length(strArr[0]);

   for i := 1 to nCount - 1 do
   begin
      tLen := Length(strArr[i]) + tLen;
      if (tLen > maxSymbInStr) then
      begin
        Result := Result + strNewLine;
        tLen   := 0;
      end;
      Result := Result + strArr[i];
   end;
end;


end.
