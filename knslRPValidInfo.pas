unit knslRPValidInfo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FR_Class, BaseGrid, AdvGrid, utlconst, utltypes, utldatabase, utlTimeDate,
  utlbox,utlexparcer, FR_Desgn;

type
  TRPValidInfo = class(TForm)
    frReport1: TfrReport;
    frDesigner1: TfrDesigner;
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
    procedure frReport1ManualBuild(Page: TfrPage);
    procedure frReport1EnterRect(Memo: TStringList; View: TfrView);
  private
    { Private declarations }
    FDB               : PCDBDynamicConn;
    FsgGrid           : PTAdvStringGrid;
    glKindEn          : string;
    globalTitle       : string;
    globalMeterName   : string;
    glTable1Name      : string;
    glValSlice        : string;
    glValDay          : string;
    glValMonth        : string;
    MeterN            : string;
    glDateInvalid     : string;
    glTimeInvalid     : string;
    glTypeData        : string;
    glDateEvent       : string;
    glTimeEvent       : string;
    glEventType       : string;
    glEventName       : string;
    GroupID           : integer;
    DateReport        : TDateTime;
    FABOID            : Integer;
    clSrez            : Integer;
    clDay             : Integer;
    clMonth           : Integer;
    IsFirstPage       : boolean;
    DatesToLoadEvMet  : array [1..31] of integer;
    DatesToLoadEvArm  : array [1..31] of integer;
    procedure SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
    procedure OnFormResize;
    procedure FillReportEventsArm(var Page: TfrPage);
    procedure FillReportEventsMet(MID : integer; var Page: TfrPage);
    procedure FillReportDatesSl(DaysNumb, MID : integer; var Page: TfrPage);
    procedure FillReportDatesArDay(DaysNumb, MID : integer; var Page: TfrPage);
    procedure FillReportDatesArMn(DaysNumb, MID : integer; var Page: TfrPage);
    procedure FillReport(var Page: TfrPage);
    function  FindValSlice(DaysNumb, MID : integer) : extended;
    function  FindValDay(DaysNumb, MID : integer) : extended;
    function  FindValMonth(DaysNumb, MID : integer) : extended;
  public
    { Public declarations }
    WorksName   : string;
    FirstSign   : string;
    SecondSign  : string;
    ThirdSign   : string;
    NDogovor    : string;
    NameObject  : string;
    Adress      : string;
    m_strObjCode: string;
    KindEnergy  : integer;
    procedure PrepareTable;
    procedure PrintPreview(Date : TDateTime);
  public
    property PsgGrid     :PTAdvStringGrid  read FsgGrid      write FsgGrid;
    property prGroupID   :integer read GroupID write GroupID;
    property PDB         :PCDBDynamicConn  read FDB          write FDB;
    property PABOID      :Integer          read FABOID       write FABOID;
  end;

var
  RPValidInfo: TRPValidInfo;
const                   
  strEnergy   : array [0..3] of string = ('Вид энергии : Активная потребляемая(кВт*ч)',
                                          'Вид энергии : Активная отдаваемая(кВт*ч)',
                                          'Вид энергии : Реактивная потребляемая(кВар*ч)',
                                          'Вид энергии : Реактивная отдаваемая(кВар*ч)');
  clColors    : array [0..3] of TColor = (clWhite, $7FFF00, $6A6AFF, $00FFFF);
implementation

{$R *.DFM}

procedure TRPValidInfo.SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
Var
    i : Integer;
Begin
        for i:=0 to sgGrid.RowCount-1 do Begin sgGrid.Cells[0,i+1] := IntToStr(i+1); sgGrid.RowHeights[i]:= nHigth;End;
End;

procedure TRPValidInfo.OnFormResize;
Var
    i : Integer;
Begin
    if FsgGrid=Nil then exit;
    for i:=1 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1));
    //PChild.OnFormResize;
End;

procedure TRPValidInfo.PrepareTable;
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
   SetHigthGrid(FsgGrid^,20);
   if not FDB.GetMeterTableForReport(FABOID,GroupID, Meters) then
     FsgGrid.RowCount := 1
   else
   begin
     FsgGrid.RowCount := Meters.Count+1;
     for i := 0 to Meters.Count - 1 do
     begin
       FsgGrid.Cells[0,i+1] := IntToStr(Meters.m_sMeter[i].m_swVMID);
       FsgGrid.Cells[1,i+1] := Meters.m_sMeter[i].m_sVMeterName;
       FsgGrid.Cells[2,i+1] := Meters.m_sMeter[i].m_sddPHAddres;
       FsgGrid.Cells[3,i+1] := DVLS(Meters.m_sMeter[i].m_sfKI*Meters.m_sMeter[i].m_sfKU);
       FsgGrid.Cells[4,i+1] := Meters.m_sMeter[i].m_sName;
     end;
   end;
   OnFormResize;
end;

procedure TRPValidInfo.PrintPreview(Date : TDateTime);
begin
   DateReport   := Date;
   glTable1Name := 'Таблица 1';
   frReport1.ShowReport;
end;

function TRPValidInfo.FindValSlice(DaysNumb, MID : integer) : extended;
var m_pGrData         : L3GRAPHDATAS;
    Perc              : extended;
begin
   FDB.GetGraphDatas(DateReport, cDateTimeR.GetBeginMonth(DateReport), MID,
                                QRY_SRES_ENR_EP + KindEnergy, m_pGrData);
   Perc := m_pGrData.Count/DaysNumb;
   if Perc > 1 then
     Perc := 1;
   Result := Perc*100;
end;

function TRPValidInfo.FindValDay(DaysNumb, MID : integer) : extended;
var Data                : CCDatas;
    Perc                : extended;
begin
   FDB.GetGData(DateReport, cDateTimeR.GetBeginMonth(DateReport), MID,
                         QRY_ENERGY_DAY_EP + KindEnergy, 1, Data);
   Perc := Data.Count/DaysNumb/2;
   FDB.GetGData(DateReport, cDateTimeR.GetBeginMonth(DateReport), MID,
                         QRY_NAK_EN_DAY_EP + KindEnergy, 1, Data);
   Perc := Perc + Data.Count/DaysNumb/2;
   if Perc > 1 then
     Perc := 1;
   Result := Perc*100;
end;

function TRPValidInfo.FindValMonth(DaysNumb, MID : integer) : extended;
var Data                : CCDatas;
    Perc                : extended;
begin
   FDB.GetGData(DateReport, cDateTimeR.GetBeginMonth(DateReport), MID,
                         QRY_NAK_EN_MONTH_EP + KindEnergy, 1, Data);
   Perc := Data.Count / 2;
   FDB.GetGData(DateReport, cDateTimeR.GetBeginMonth(DateReport), MID,
                         QRY_ENERGY_MON_EP + KindEnergy, 1, Data);
   Perc := Perc + Data.Count / 2;
   if Perc > 1 then
     Perc := 1;
   Result := Perc*100;
end;

procedure TRPValidInfo.FillReportEventsMet(MID : integer; var Page: TfrPage);
var pTable           : SEVENTTAGS;
    i                : integer;
    IsEv             : boolean;
    Year, Month, Day : word;
begin
   Page.ShowBandByName('MasterHeader2');
   IsEv  := false;
//   FDB.ReadJrnlEx(2, MID, cDateTimeR.GetBeginMonth(DateReport), DateReport, pTable);
   for i := 0 to pTable.Count - 1 do
   begin
     DecodeDate(pTable.Items[i].m_sdtEventTime, Year, Month, Day);
     if DatesToLoadEvMet[Day] <> 0 then
     begin
       IsEv        := true;
       glDateEvent := DateTimeToStr(pTable.Items[i].m_sdtEventTime);
       glTimeEvent := TimeToStr(pTable.Items[i].m_sdtEventTime);
       glEventType := 'События счетчика';
       glEventName := m_nJrnlN3.Strings[pTable.Items[i].m_swEventID];
       Page.ShowBandByName('MasterData3');
     end;
   end;
//   FDB.ReadJrnlEx(1, MID, cDateTimeR.GetBeginMonth(DateReport), DateReport, pTable);
   for i := 0 to pTable.Count - 1 do
   begin
     DecodeDate(pTable.Items[i].m_sdtEventTime, Year, Month, Day);
     if DatesToLoadEvMet[Day] <> 0 then
     begin
       IsEv        := true;
       glDateEvent := DateTimeToStr(pTable.Items[i].m_sdtEventTime);
       glTimeEvent := TimeToStr(pTable.Items[i].m_sdtEventTime);
       glEventType := 'Ошибки обмена';
       glEventName := m_nJrnlN2.Strings[pTable.Items[i].m_swEventID];
       Page.ShowBandByName('MasterData3');
     end;
   end;
   if not IsEv then
   begin
     glDateEvent := '-';
     glTimeEvent := '-';
     glEventType := '-';
     glEventName := 'Событий связанных со счетиком не обнаружено';
     Page.ShowBandByName('MasterData3');
   end;
end;

procedure TRPValidInfo.FillReportEventsArm(var Page: TfrPage);
var pTable           : SEVENTTAGS;
    i                : integer;
    IsEv             : boolean;
    Year, Month, Day : word;
begin
   Page.ShowBandByName('MasterHeader2');
   IsEv  := false;
//   FDB.ReadJrnlEx(0, -1, cDateTimeR.GetBeginMonth(DateReport), DateReport, pTable);
   for i := 0 to pTable.Count - 1 do
   begin
     DecodeDate(pTable.Items[i].m_sdtEventTime, Year, Month, Day);
     if DatesToLoadEvArm[Day] <> 0 then
     begin
       IsEv        := true;
       glDateEvent := DateTimeToStr(pTable.Items[i].m_sdtEventTime);
       glTimeEvent := TimeToStr(pTable.Items[i].m_sdtEventTime);
       glEventType := 'События системы';
       if pTable.Items[i].m_swEventID<=m_nJrnlN1.Count-1 then 
       glEventName := m_nJrnlN1.Strings[pTable.Items[i].m_swEventID];
       Page.ShowBandByName('MasterData3');
     end;
   end;
   if not IsEv then
   begin
     glDateEvent := '-';
     glTimeEvent := '-';
     glEventType := '-';
     glEventName := 'Событий АРМ-а или УСПД не обнаружено';
     Page.ShowBandByName('MasterData3');
   end;
end;

procedure TRPValidInfo.FillReportDatesSl(DaysNumb, MID : integer; var Page: TfrPage);
var m_pGrData         : L3GRAPHDATAS;
    i, j              : integer;
    Year, Month, Day  : word;
begin
   FDB.GetGraphDatas(DateReport, cDateTimeR.GetBeginMonth(DateReport), MID,
                     QRY_SRES_ENR_EP + KindEnergy, m_pGrData);
   if m_pGrData.Count <> DaysNumb then
   begin
     j := 0;
     for i := trunc(cDateTimeR.GetBeginMonth(DateReport)) to trunc(DateReport) do
     begin
       if i > trunc(Now) then
         break;
       if (j <= m_pGrData.Count - 1) and (trunc(m_pGrData.Items[j].m_sdtDate) = i) then
         Inc(j)
       else
       begin
         DecodeDate(i, Year, Month, Day);
         DatesToLoadEvMet[Day] := i;
         DatesToLoadEvArm[Day] := i;
         glDateInvalid         := DateToStr(i);
         glTimeInvalid         := TimeToStr(EncodeTime(0,0,0,0));
         glTypeData            := 'Нет данных по срезам за день';
         Page.ShowBandByName('MasterData2');
       end;
     end;
   end;
end;

procedure TRPValidInfo.FillReportDatesArDay(DaysNumb, MID : integer; var Page: TfrPage);
var Data                : CCDatas;
    i, j                : integer;
    Year, Month, Day    : word;
begin
   FDB.GetGData(DateReport, cDateTimeR.GetBeginMonth(DateReport), MID,
                         QRY_ENERGY_DAY_EP + KindEnergy, 1, Data);
   if Data.Count <> DaysNumb then
   begin
     j := 0;
     for i := trunc(cDateTimeR.GetBeginMonth(DateReport)) to trunc(DateReport) do
     begin
       if i > trunc(Now) then
         break;
       if (j <= Data.Count - 1) and (trunc(Data.Items[j].m_sTime) = i) then
         Inc(j)
       else
       begin
         DecodeDate(i, Year, Month, Day);
         DatesToLoadEvMet[Day] := i;
         DatesToLoadEvArm[Day] := i;
         glDateInvalid         := DateToStr(i);
         glTimeInvalid         := TimeToStr(EncodeTime(0,0,0,0));
         glTypeData            := 'Нет данных по приращению энергии за день';
         Page.ShowBandByName('MasterData2');
       end;
     end;
   end;
   FDB.GetGData(DateReport, cDateTimeR.GetBeginMonth(DateReport), MID,
                         QRY_NAK_EN_DAY_EP + KindEnergy, 1, Data);
   if Data.Count <> DaysNumb then
   begin
     j := 0;
     for i := trunc(cDateTimeR.GetBeginMonth(DateReport)) to trunc(DateReport) do
     begin
       if i > trunc(Now) then
         break;
       if (j <= Data.Count - 1) and (trunc(Data.Items[j].m_sTime) = i) then
         Inc(j)
       else
       begin
         DecodeDate(i, Year, Month, Day);
         DatesToLoadEvMet[Day] := i;
         DatesToLoadEvArm[Day] := i;
         glDateInvalid         := DateToStr(i);
         glTimeInvalid         := TimeToStr(EncodeTime(0,0,0,0));
         glTypeData            := 'Нет данных по накопленной энергии на начало дня';
         Page.ShowBandByName('MasterData2');
       end;
     end;
   end;
end;

procedure TRPValidInfo.FillReportDatesArMn(DaysNumb, MID : integer; var Page: TfrPage);
var Data                : CCDatas;
    Year, Month, Day    : word;
begin
   FDB.GetGData(DateReport, cDateTimeR.GetBeginMonth(DateReport), MID,
                         QRY_NAK_EN_MONTH_EP + KindEnergy, 1, Data);
   if Data.Count = 0 then
   begin
     DatesToLoadEvMet[1] := trunc(cDateTimeR.GetBeginMonth(DateReport));
     DatesToLoadEvArm[1] := trunc(cDateTimeR.GetBeginMonth(DateReport));
     glDateInvalid       := DateToStr(cDateTimeR.GetBeginMonth(DateReport));
     glTimeInvalid       := TimeToStr(EncodeTime(0,0,0,0));
     glTypeData          := 'Нет данных по накопленной по приращению энергии за месяц';
     Page.ShowBandByName('MasterData2');
   end;
   FDB.GetGData(DateReport, cDateTimeR.GetBeginMonth(DateReport), MID,
                         QRY_ENERGY_MON_EP + KindEnergy, 1, Data);
   if Data.Count = 0 then
   begin
     DatesToLoadEvMet[1] := trunc(cDateTimeR.GetBeginMonth(DateReport));
     DatesToLoadEvArm[1] := trunc(cDateTimeR.GetBeginMonth(DateReport));
     glDateInvalid       := DateToStr(cDateTimeR.GetBeginMonth(DateReport));
     glTimeInvalid       := TimeToStr(EncodeTime(0,0,0,0));
     glTypeData          := 'Нет данных по накопленной по приращению энергии за месяц';
     Page.ShowBandByName('MasterData2');
   end;
end;

procedure TRPValidInfo.FillReport(var Page: TfrPage);
var i, j                       : integer;
    DaysNumb                   : integer;
    Year, Month, Day           : word;
    YearN, MonthN, DayN        : word;
    PercSl, PercDay, PercMonth : extended;
begin
   DecodeDate(Now, YearN, MonthN, DayN);
   DecodeDate(DateReport, Year, Month, Day);
   if (YearN = Year) and (MonthN = Month) then
     DaysNumb := DayN
   else
     DaysNumb := cDateTimeR.DayPerMonth(Month, Year);
   for i := 1 to FsgGrid.RowCount - 1 do
   begin
     globalMeterName := 'Точка учета :' + FsgGrid.Cells[1, i];
     MeterN          := 'Эл. сч. №' + FsgGrid.Cells[2, i];
     PercSl     := FindValSlice(DaysNumb, StrToInt(FsgGrid.Cells[0, i]));
     PercDay    := FindValDay(DaysNumb, StrToInt(FsgGrid.Cells[0, i]));
     PercMonth  := FindValMonth(DaysNumb, StrToInt(FsgGrid.Cells[0, i]));
     if (FsgGrid.Cells[4, i] = 'SUMM') or (FsgGrid.Cells[4, i] = 'GSUMM') then
     begin
       if (PercDay <= 50) then
         PercDay := PercDay*2;
       if (PercMonth <=50) then
         PercMonth := PercMonth*2;
     end;
     glValSlice := FloatToStrF(PercSl, ffFixed, 10, 2) + '%';
     glValDay   := FloatToStrF(PercDay, ffFixed, 10, 2) + '%';
     glValMonth := FloatToStrF(PercMonth, ffFixed, 10, 2) + '%';
     if PercSl<50   then clSrez  := 2 else
     if (PercSl>=50)and(PercSl<100) then clSrez := 3 else
     if PercSl=100  then clSrez := 1;

     if PercDay<50   then clDay  := 2 else
     if (PercDay>=50)and(PercDay<100) then clDay := 3 else
     if PercDay=100  then clDay := 1;

     if PercMonth<50   then clMonth  := 2 else
     if (PercMonth>=50)and(PercMonth<100) then clMonth := 3 else
     if PercMonth=100  then clMonth := 1;

     Page.ShowBandByName('MasterData1');
     IsFirstPage := false;
     if (PercSl <> 100) or (PercDay <> 100) or (PercMonth <> 100) then
     begin
       Page.ShowBandByName('MasterHeader1');
       for j := 1 to 31 do
         DatesToLoadEvMet[j] := 0;
       if PercSl <> 100 then FillReportDatesSl(DaysNumb, StrToInt(FsgGrid.Cells[0, i]), Page);
       if PercDay <> 100 then FillReportDatesArDay(DaysNumb, StrToInt(FsgGrid.Cells[0, i]), Page);
       if PercMonth <> 100 then FillReportDatesArMn(DaysNumb, StrToInt(FsgGrid.Cells[0, i]), Page);
       //FillReportEventsMet(StrToInt(FsgGrid.Cells[0, i]), Page);
     end;
   end;
   FillReportEventsArm(Page);
end;

procedure TRPValidInfo.frReport1ManualBuild(Page: TfrPage);
var Year, Month, Day : word;
    i                : integer;
begin
   for i := 1 to 31 do
   begin
     DatesToLoadEvMet[i] := 0;
     DatesToLoadEvArm[i] := 0;
   end;
   IsFirstPage := true;
   DecodeDate(DateReport, Year, Month, Day);
   globalTitle := 'Отчет о полноте сбора данных в ' +
                     cDateTimeR.GetNameMonth(Month)+ ' ' + IntToStr(Year) + ' года';
   glKindEn    := strEnergy[KindEnergy];
   Page.ShowBandByType(btReportTitle);
   FillReport(Page);
   //Page.ShowBandByName('MasterData1');
   Page.ShowBandByName('PageFooter1');
end;

procedure TRPValidInfo.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin
   if ParName = 'WorksName'     then ParValue := WorksName;
   if ParName = 'FirstSign'     then ParValue := FirstSign;
   if ParName = 'ThirdSign'     then ParValue := ThirdSign;
   if ParName = 'SecondSign'    then ParValue := SecondSign;
   if ParName = 'TtlMainName'   then ParValue := globalTitle;
   if ParName = 'MDNameCounter' then ParValue := globalMeterName;
   if ParName = 'MeterN'        then ParValue := MeterN;
   if ParName = 'KindEn'        then ParValue := glKindEn;
   if ParName = 'NDogovor'      then ParValue := NDogovor;
   if ParName = 'NameObject'    then ParValue := NameObject;
   if ParName = 'Adress'        then ParValue := Adress;
   if ParName = 'Tbl1Name'      then ParValue := glTable1Name;
   if ParName = 'ValidSlice'    then ParValue := glValSlice;
   if ParName = 'ValidDay'      then ParValue := glValDay;
   if ParName = 'ValidMonth'    then ParValue := glValMonth;
   if ParName = 'DateInvalid'   then ParValue := glDateInvalid;
   if ParName = 'TimeInvalid'   then ParValue := glTimeInvalid;
   if ParName = 'TypeData'      then ParValue := glTypeData;
   if ParName = 'DateEvent'     then ParValue := glDateEvent;
   if ParName = 'TimeEvent'     then ParValue := glTimeEvent;
   if ParName = 'EventType'     then ParValue := glEventType;
   if ParName = 'EventName'     then ParValue := glEventName;
end;

procedure TRPValidInfo.frReport1EnterRect(Memo: TStringList;
  View: TfrView);
begin
   if not IsFirstPage then
     if  (View.Name = 'Memo9') or (View.Name = 'Memo47') then
       View.Visible := false;

   if View.Name = 'Memo11' then View.FillColor := clColors[clSrez];
   if View.Name = 'Memo6'  then View.FillColor := clColors[clDay];
   if View.Name = 'Memo7'  then View.FillColor := clColors[clMonth];
   if View.Name = 'Memo28'  then View.FillColor := $00E1FFE1;

end;

end.
