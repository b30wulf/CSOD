unit knslRPRasxEnergy2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FR_Class, BaseGrid, AdvGrid, utlconst, utltypes, utldatabase, utlTimeDate,
  FR_Desgn, utlbox;

type
  TRPRasxEnergy2 = class(TForm)
    frReport1: TfrReport;
    procedure frReport1ManualBuild(Page: TfrPage);
    procedure frReport1GetValue(const ParName: String; var ParValue: Variant);
  private
    { Private declarations }
    VMeters           : SL3GROUPTAG;
    m_pGrData         : L3GRAPHDATAS;
    m_pTariffs        : TM_TARIFFS;
    FTID              : Integer;
    FsgGrid           : PTAdvStringGrid;
    DateReport        : TDateTime;
    ItemInd           : Integer;
    m_Precision       : Integer;
    globalTtlMainName : string;
    globalTblName     : string;
    globalTblDate     : string[15];
    globalTblDosInf   : string[10];
    globalTblTName    : array [0..3] of string;
    globalTblTTimes   : array [0..3] of string;
    
    globalTblDaySumT  : array [0..4] of string[15];
    PrirDay           : array [0..3,0..31] of extended;
    IsData            : array [0..3,0..31] of boolean;
    SumEnerg          : array [0..4] of extended;
    PlaneInd          : Integer;
    PlaneName         : string;
    FDB               : PCDBDynamicConn;
    FABOID            : Integer;
    procedure ReadArch(TempDate : TDateTime);
    procedure ReadArchAbonent(TempDate : TDateTime);
    function  GetColorFromTariffs(Srez:byte; var pTable:TM_TARIFFS):Byte;
    procedure FillReport(Date : TDateTime);
    function  DateOutSec(Date : TDateTime) : string;
    procedure CreateTariffsNames();
    function  GetTariffAlias(const _TarName: String) : String;
    procedure ReadArchForEMS(TempDate : TDateTime; VMID : integer);
    procedure ReadArchForCE6822(TempDate : TDateTime; VMID : integer);
    function  FindNumOfGroups(var str: string):integer;
    function  GetGrStartPos(var str: string; stFP: integer):integer;
    procedure GetGrPos(var str:string; stFindPos:integer; var BP, EP : integer);
    function  GetGrStringArr(var str : string; maxSymbInStr : integer) : string;
  public
    { Public declarations }
    IsRPGroup   : boolean;
    KindEnergy  : integer;
    WorksName   : string;
    FirstSign   : string;
    ThirdSign    : string;
    SecondSign  : string;
    NDogovor    : string;
    NameObject  : string;
    Adress      : string;
    m_strObjCode: string;
    procedure OnFormResize;
    procedure PrepareTable;
    procedure PrepareTableSub;
    procedure PrintPreview(Date : TDateTime; ItemIndMaxCtrl:Integer);
  public
    property PsgGrid     :PTAdvStringGrid  read FsgGrid      write FsgGrid;
    property PABOID      :Integer          read FABOID       write FABOID;
    property PDB         :PCDBDynamicConn  read FDB          write FDB;
    property Precision   : Integer         read m_Precision write m_Precision;
  end;

var
  RPRasxEnergy2 : TRPRasxEnergy2;

const
  c_EnergyNames : array[0..3] of string = ('����������� ��������',
                                           '���������� ��������',
                                           '����������� ����������',
                                           '���������� ����������');

  c_EnergyUnits : array[0..3] of string = ('����',
                                           '����',
                                           '�����',
                                           '�����');
const MAX_STR_CONFIG_LEN : integer = 100;
const strNewLine         : string  = #13;

implementation

{$R *.DFM}

procedure TRPRasxEnergy2.ReadArchForEMS(TempDate : TDateTime; VMID : integer);
var DataRazn            : CCDatas;
    i, j                : byte;
    Day, Month, Year    : word;
begin
  if not FDB.GetGData(TempDate, TempDate, VMID,
                      QRY_ENERGY_MON_EP + KindEnergy, 0, DataRazn) then
    exit;
  DecodeDate(TempDate, Year, Month, Day);
  for i := 0 to DataRazn.Count - 1 do
    DataRazn.Items[i].m_sfValue := DataRazn.Items[i].m_sfValue/cDateTimeR.DayPerMonth(Month, Year);
  for i := 0 to cDateTimeR.DayPerMonth(Month, Year) - 1 do
    for j := 0 to DataRazn.Count - 1 do
    begin
      if (DataRazn.Items[j].m_swTID = 0) or (DataRazn.Items[j].m_swTID = 4) then
        continue;
      PrirDay[j, i] := PrirDay[j, i] + DataRazn.Items[j].m_sfValue;
      IsData[j, i]  := true;
    end;
end;

procedure TRPRasxEnergy2.ReadArchForCE6822(TempDate : TDateTime; VMID : integer);
var DataRazn1, DataRazn2  : CCDatas;
    i, j                  : byte;
    Day, Month, Year      : word;
begin
  DecodeDate(TempDate, Year, Month, Day);
  if not FDB.GetGData(TempDate, TempDate, VMID,
                      QRY_NAK_EN_MONTH_EP + KindEnergy, 0, DataRazn1) then
    exit;
  for i := 0 to DataRazn1.Count - 1 do
    DataRazn1.Items[i].m_sfValue := DataRazn1.Items[i].m_sfValue/cDateTimeR.DayPerMonth(Month, Year);
  cDateTimeR.DecMonth(TempDate);
  if not FDB.GetGData(TempDate, TempDate, VMID,
                      QRY_NAK_EN_MONTH_EP + KindEnergy, 0, DataRazn2) then
    exit;
  for i := 0 to DataRazn2.Count - 1 do
    DataRazn2.Items[i].m_sfValue := DataRazn2.Items[i].m_sfValue/cDateTimeR.DayPerMonth(Month, Year);

  for i := 0 to cDateTimeR.DayPerMonth(Month, Year) - 1 do
    for j := 0 to DataRazn1.Count - 1 do
    begin
      if (DataRazn1.Items[j].m_swTID = 0) or  (DataRazn1.Items[j].m_swTID = 4)
          or (DataRazn2.Items[j].m_swTID = 0) or  (DataRazn2.Items[j].m_swTID = 4) then
          continue;
      PrirDay[j, i] := PrirDay[j, i] + DataRazn1.Items[j].m_sfValue - DataRazn2.Items[j].m_sfValue;
      IsData[j, i]  := true;
    end;
end;

function TRPRasxEnergy2.DateOutSec(Date : TDateTime) : string;
var str : string;
begin
   str := TimeToStr(Date);
   SetLength(str, Length(str) - 3);
   Result := str;
end;

procedure TRPRasxEnergy2.CreateTariffsNames();
var i : integer;
begin
  for i := 0 to 3 do
  begin
    globalTblTName[i] := '';
    globalTblTTimes[i] := '';
  end;
  for i := 1 to m_pTariffs.Count - 1 do
  begin
    if globalTblTName[m_pTariffs.Items[i].m_swTID-1] = '' then
    begin
      globalTblTName[m_pTariffs.Items[i].m_swTID-1] := GetTariffAlias(m_pTariffs.Items[i].m_sName);
      globalTblTTimes[m_pTariffs.Items[i].m_swTID-1] := DateOutSec(m_pTariffs.Items[i].m_dtTime0) + '-' + DateOutSec(m_pTariffs.Items[i].m_dtTime1);
    end
    else
      globalTblTTimes[m_pTariffs.Items[i].m_swTID-1] := globalTblTTimes[m_pTariffs.Items[i].m_swTID-1] +','
        + DateOutSec(m_pTariffs.Items[i].m_dtTime0) + '-' + DateOutSec(m_pTariffs.Items[i].m_dtTime1);
  end;
  for i := 0 to 3 do
    if globalTblTName[i] = '' then
      globalTblTName[i] := '����� �� ���������';
end;

function TRPRasxEnergy2.GetColorFromTariffs(Srez:byte; var pTable:TM_TARIFFS):Byte;
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

procedure TRPRasxEnergy2.PrepareTable;
var Groups : SL3INITTAG;
    i      : integer;
begin
   if FsgGrid=Nil then
     exit;
   FsgGrid.ColCount   := 2;
   FsgGrid.Cells[0,0] := '� �.�';
   FsgGrid.Cells[1,0] := '������������ ������';
   FsgGrid.ColWidths[0]  := 30;
   if not FDB.GetAbonGroupsLVTable(FABOID,1,Groups) then
     FsgGrid.RowCount := 1
   else
   begin
     FsgGrid.RowCount := Groups.Count + 1;
     for i := 0 to Groups.Count - 1 do
     begin
       FsgGrid.Cells[0, i + 1] := IntToStr(Groups.Items[i].m_sbyGroupID);
       FsgGrid.Cells[1, i + 1] := Groups.Items[i].m_sGroupName;
     end;
   end;
   OnFormResize;
end;

procedure TRPRasxEnergy2.PrepareTableSub;
var Meters : SL2TAGREPORTLIST;
    i      : integer;
begin
   if FsgGrid=Nil then exit;
   FsgGrid.ColCount      := 5;
   FsgGrid.RowCount      := 60;
   FsgGrid.Cells[0,0]    := '� �.�';
   FsgGrid.Cells[1,0]    := '������������ �����';
   FsgGrid.Cells[2,0]    := '����� ��������';
   FsgGrid.Cells[3,0]    := '�����������';
   FsgGrid.Cells[4,0]    := '��� ��������';
   FsgGrid.ColWidths[0]  := 30;
//   FDB.GetMetersAll(Meters)

   if not FDB.GetMeterGLVTableForReport(FABOID,-1,0, Meters) then
     FsgGrid.RowCount := 1
   else
   begin
     FsgGrid.RowCount := Meters.Count+1;
     for i := 0 to Meters.Count - 1 do
     begin
       {if (Meters.m_sMeter[i].m_sbyType = MET_SUMM) or (Meters.m_sMeter[i].m_sbyType = MET_GSUMM) or
          (Meters.m_sMeter[i].m_sbyType = MET_VZLJOT) then
         continue;
       }
       FsgGrid.Cells[0,i+1] := IntToStr(Meters.m_sMeter[i].m_swVMID);
       FsgGrid.Cells[1,i+1] := Meters.m_sMeter[i].m_sVMeterName;
       FsgGrid.Cells[2,i+1] := Meters.m_sMeter[i].m_sddPHAddres;
       FsgGrid.Cells[3,i+1] := DVLS(Meters.m_sMeter[i].m_sfKI*Meters.m_sMeter[i].m_sfKU);
       FsgGrid.Cells[4,i+1] := Meters.m_sMeter[i].m_sName;
     end;

   end;
   OnFormResize;
end;


procedure TRPRasxEnergy2.OnFormResize;
Var
    i : Integer;
Begin
    if FsgGrid=Nil then exit;
    for i:=1 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1));
    //PChild.OnFormResize;
End;

procedure TRPRasxEnergy2.PrintPreview(Date : TDateTime; ItemIndMaxCtrl:Integer);
begin
  if m_Precision < 0 then
    m_Precision := 0;
   //FsgGrid   := @pTable;
   DateReport  := Date;
   if ItemIndMaxCtrl = 0 then
     ItemInd     := 1
   else
     ItemInd     := ItemIndMaxCtrl;
   FTID        := FDB.LoadTID(QRY_SRES_ENR_EP + KindEnergy);;
   frReport1.ShowReport;
end;

procedure TRPRasxEnergy2.ReadArch(TempDate : TDateTime);
var i, j, k          : word;
    Year, Month, Day : word;
    Index            : word;
    DateBeg, DateEnd : TDateTime;
begin
   DecodeDate(TempDate, Year, Month, Day);
   Day := 1;
   DateBeg := EncodeDate(Year, Month, Day);
   Day := cDateTimeR.DayPerMonth(Month, Year);
   DateEnd := EncodeDate(Year, Month, Day);
   for i := 0 to VMeters.m_swAmVMeter-1 do
   begin
     //if (VMeters.Item.Items[i].m_sbyType = MET_SUMM) or (VMeters.Item.Items[i].m_sbyType = MET_GSUMM)  then
     //  continue;

     if not FDB.GetGraphDatas(DateEnd, DateBeg, VMeters.Item.Items[i].m_swVMID,
                                QRY_SRES_ENR_EP + KindEnergy, m_pGrData) then
       continue
     else
       for k := 0 to m_pGrData.Count - 1 do
       begin

         DecodeDate(m_pGrData.Items[k].m_sdtDate, Year, Month, Day);
         Dec(Day);
         for j := 0 to 47 do
         begin
        //    if j <> 0 then
        //     Index := GetColorFromTariffs(j + 1, m_pTariffs) - 1
       //    else
           Index := GetColorFromTariffs(j, m_pTariffs) - 1;
           PrirDay[Index, Day] := PrirDay[Index, Day] + m_pGrData.Items[k].v[j];
           //fExt := fExt + m_pGrData.Items[k].v[j];
           //PrirDay[Index, Day] := fExt;
           IsData[Index, Day]  := true;
         end;
         //if Day=26 then
         //PrirDay[Index, Day] := fExt;
       end;
   end;
   for i := 0 to VMeters.m_swAmVMeter-1 do
   begin
     if VMeters.Item.Items[i].m_sbyType = MET_EMS134 then
       ReadArchForEMS(TempDate, VMeters.Item.Items[i].m_swVMID);
     if VMeters.Item.Items[i].m_sbyType = MET_CE6822 then
       ReadArchForCE6822(TempDate, VMeters.Item.Items[i].m_swVMID);
   end;
end;

procedure TRPRasxEnergy2.ReadArchAbonent(TempDate : TDateTime);
var j, k          : word;
    Year, Month, Day : word;
    Index            : word;
    DateBeg, DateEnd : TDateTime;
begin
   DecodeDate(TempDate, Year, Month, Day);
   Day := 1;
   DateBeg := EncodeDate(Year, Month, Day);
   Day := cDateTimeR.DayPerMonth(Month, Year);
   DateEnd := EncodeDate(Year, Month, Day);
   if FDB.GetGraphDatas(DateEnd, DateBeg, StrToInt(FsgGrid.Cells[0, ItemInd]),
                           QRY_SRES_ENR_EP + KindEnergy, m_pGrData) then
     for k := 0 to m_pGrData.Count - 1 do
     begin
       DecodeDate(m_pGrData.Items[k].m_sdtDate, Year, Month, Day);
       Dec(Day);
       for j := 0 to 47 do
       begin
        // if j <> 0 then
       //    Index := GetColorFromTariffs(j + 1, m_pTariffs) - 1
      //   else
           Index := GetColorFromTariffs(j, m_pTariffs) - 1;
         PrirDay[Index, Day] := PrirDay[Index, Day] + m_pGrData.Items[k].v[j];
         IsData[Index, Day]  := true;
       end;
     end;
end;

procedure TRPRasxEnergy2.FillReport(Date : TDateTime);
var i                : byte;
    Year, Month, Day : word;
begin
   DecodeDate(Date, Year, Month, Day);
   Day := Day - 1;
   PrirDay[0, 31] := 0;
   globalTblDate  := DateToStr(Date);
   for i := 0 to 3 do
   begin
     if not IsData[i, Day] then
     begin
       globalTblDaySumT[i] := '--';
       continue;
     end;
     globalTblDaySumT[i] := FloatToStrF(PrirDay[i, Day], ffFixed, 18, m_Precision);
     PrirDay[0, 31] := PrirDay[0, 31] + PrirDay[i, Day];
     SumEnerg[i]    := SumEnerg[i] + PrirDay[i][Day];
   end;
   PrirDay[1, 31] := PrirDay[1, 31] + PrirDay[0, 31];
end;

procedure TRPRasxEnergy2.frReport1ManualBuild(Page: TfrPage);
var Year, Month, Day : word;
    i, j             : integer;
    TempDate         : TDateTime;
    nGroup : Integer;
begin
   DecodeDate(DateReport, Year, Month, Day);
   for i := 0 to 3 do
   begin
     for j := 0 to 31 do
     begin
       PrirDay[i, j] := 0;
       IsData[i, j]  := false;
     end;
     SumEnerg[i] := 0;
   end;

  NDogovor := trim(NDogovor);
   globalTtlMainName := '���������� ' + c_EnergyNames[KindEnergy] + ' ������� � ' + cDateTimeR.GetNameMonth(Month)
                         + ' ' + IntToStr(Year) + ' ����';

   globalTblName  := FsgGrid.Cells[1, ItemInd];
   if IsRPGroup then
   Begin
     //PlaneInd := FDB.GetTMTarPeriodsTableGr(StrToInt(FsgGrid.Cells[0, ItemInd]), FTID{ + KindEnergy}, m_pTariffs)
     FDB.GetVMetersTable(FABOID,StrToInt(FsgGrid.Cells[0, ItemInd]), VMeters);
     PlaneInd := FDB.GetTMTarPeriodsCmdTable(DateReport,VMeters.Item.Items[0].m_swVMID,QRY_SRES_ENR_EP + KindEnergy,0,m_pTariffs);
   End
   else
     PlaneInd := FDB.GetTMTarPeriodsCmdTable(DateReport,StrToInt(FsgGrid.Cells[0, ItemInd]),QRY_SRES_ENR_EP + KindEnergy,0,m_pTariffs);
     //PlaneInd := FDB.GetTMTarPeriodsTable(StrToInt(FsgGrid.Cells[0, ItemInd]), FTID{ + KindEnergy}, m_pTariffs);
   PlaneName := FDB.GetPlaneName(PlaneInd);
   Page.ShowBandByType(btReportTitle);

   CreateTariffsNames;

   if IsRPGroup then
   begin
     nGroup := StrToInt(FsgGrid.Cells[0, ItemInd]);
     if FDB.GetVMetersTable(FABOID,nGroup, VMeters) then
       ReadArch(DateReport);
   end
   else
     ReadArchAbonent(DateReport);
   Day := 1;
   TempDate := EncodeDate(Year, Month, Day);
   while cDateTimeR.CompareMonth(TempDate, DateReport) = 0 do
   begin
     FillReport(TempDate);
     Page.ShowBandByName('MasterData1');
     cDateTimeR.IncDate(TempDate);
   end;
   Page.SHowBandByName('MasterData2');
   Page.ShowBandByName('PageFooter1');
   //FsgGrid := nil;
end;

procedure TRPRasxEnergy2.frReport1GetValue(const ParName: String; var ParValue: Variant);
begin
  if ParName = 'WorksName'        then ParValue := WorksName
  else if ParName = 'FirstSign'   then ParValue := FirstSign
  else if ParName = 'ThirdSign'   then ParValue := ThirdSign
  else if ParName = 'SecondSign'  then ParValue := SecondSign
  else if ParName = 'NDogovor'    then ParValue := NDogovor
  else if ParName = 'NameObject'  then ParValue := NameObject
  else if ParName = 'Adress'      then ParValue := Adress
  else if ParName = 'TtlMainName' then ParValue := globalTtlMainName
  else if ParName = 'TtlNameTbl'  then ParValue := GetGrStringArr(globalTblName, MAX_STR_CONFIG_LEN)
  else if ParName = 'TblDate'     then ParValue := globalTblDate
  else if ParName = 'TblDostInf'  then ParValue := globalTblDosInf
  else if ParName = 'TblT0Name'   then ParValue := '����� ���������� '+c_EnergyNames[KindEnergy]+' �������, ' + c_EnergyUnits[KindEnergy]//+#13#10;
  else if ParName = 'TblT0Times'  then ParValue := '00:00-24:00'

  else if ParName = 'TblT1Name'   then ParValue := globalTblTName[0]
  else if ParName = 'TblT1Times'  then ParValue := globalTblTTimes[0]
  else if ParName = 'TblT2Name'   then ParValue := globalTblTName[1]
  else if ParName = 'TblT2Times'  then ParValue := globalTblTTimes[1]
  else if ParName = 'TblT3Name'   then ParValue := globalTblTName[2]
  else if ParName = 'TblT3Times'  then ParValue := globalTblTTimes[2]

  else if ParName = 'TblDaySum'   then ParValue := FloatToStrF(PrirDay[0][31], ffFixed, 18, m_Precision)
  else if ParName = 'TblDayNar'   then ParValue := FloatToStrF(PrirDay[1][31], ffFixed, 18, m_Precision)
  else if ParName = 'TblDaySumT1' then ParValue := globalTblDaySumT[0]
  else if ParName = 'TblDayNarT1' then ParValue := FloatToStrF(SumEnerg[0], ffFixed, 18, m_Precision)
  else if ParName = 'TblDaySumT2' then ParValue := globalTblDaySumT[1]
  else if ParName = 'TblDayNarT2' then ParValue := FloatToStrF(SumEnerg[1], ffFixed, 18, m_Precision)
  else if ParName = 'TblDaySumT3' then ParValue := globalTblDaySumT[2]
  else if ParName = 'TblDayNarT3' then ParValue := FloatToStrF(SumEnerg[2], ffFixed, 18, m_Precision)

  else if ParName = 'TblSum'      then ParValue := FloatToStrF(PrirDay[1][31], ffFixed, 18, m_Precision)
  else if ParName = 'TblSumT1'    then ParValue := FloatToStrF(SumEnerg[0], ffFixed, 18, m_Precision)
  else if ParName = 'TblSumT2'    then ParValue := FloatToStrF(SumEnerg[1], ffFixed, 18, m_Precision)
  else if ParName = 'TblSumT3'    then ParValue := FloatToStrF(SumEnerg[2], ffFixed, 18, m_Precision)

  else if ParName = 'm_strObjCode'then Parvalue := m_strObjCode;
end;

function TRPRasxEnergy2.GetTariffAlias(const _TarName: String) : String;
begin
  if (_TarName = '����������� ����') then
    Result := '���������� '+c_EnergyNames[KindEnergy]+' ������� � ���� ����������� ����, ' + c_EnergyUnits[KindEnergy]
  else if (_TarName = '������� ����') then
    Result := '���������� '+c_EnergyNames[KindEnergy]+' ������� � ���� ������� ����, ' + c_EnergyUnits[KindEnergy]
  else if (_TarName = '������ ����') then
    Result := '���������� '+c_EnergyNames[KindEnergy]+' ������� � ���� ������ ����, ' + c_EnergyUnits[KindEnergy]
  else
    Result := _TarName + ', ' + c_EnergyUnits[KindEnergy];
end;

function TRPRasxEnergy2.FindNumOfGroups(var str: string):integer;
var i, j : integer;
begin
   Result := 1;
   for i := 1 to Length(str) do
   begin
     if (str[i] = '+') or (str[i] = '-') then
       for j := i + 1 to i + 5 do
         if (str[j] = '�') and (str[j + 1] = '�') then
         begin
           Result := Result + 1;
           break;
         end;
   end;
end;

function TRPRasxEnergy2.GetGrStartPos(var str: string; stFP: integer):integer;
var i, j : integer;
begin
   Result := Length(str);
   for i := stFP to Length(str) do
   begin
     if (str[i] = '+') or (str[i] = '-') then
       for j := i + 1 to i + 5 do
         if (str[j] = '�') and (str[j + 1] = '�') then
         begin
            Result := j - 1;
            exit;
         end;
   end;
end;

procedure TRPRasxEnergy2.GetGrPos(var str:string; stFindPos:integer; var BP, EP : integer);
begin
   BP := 0;
   EP := 0;
   BP := GetGrStartPos(str, stFindPos);
   EP := GetGrStartPos(str, BP);
end;

function TRPRasxEnergy2.GetGrStringArr(var str : string; maxSymbInStr : integer) : string;
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
