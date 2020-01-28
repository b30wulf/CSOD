unit knslRPPokMeters;

interface
{Модуль отчета: показания счетчиков текуте}
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FR_Class, utldatabase, BaseGrid, AdvGrid, utltypes, utlTimeDate, FR_DSet,
  utlconst, utlbox, FR_Desgn;
type
  TrpPokMeters = class(TForm)
    frReport1: TfrReport;
    frDesigner1: TfrDesigner;
    procedure frReport1ManualBuild(Page: TfrPage);
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
    procedure frReport1EnterRect(Memo: TStringList; View: TfrView);
  private
    { Private declarations }
    m_ID           : integer;
    glKoef         : extended;
    GroupID        : integer;
    FsgGrid        : PTAdvStringGrid;
    DateReport     : TDateTime;
    globalTitleKPD : string;
    globalTblName  : string;
    globalTblMeter : string;
    globalT        : array [0..4] of string[15];
    globalIsTInS   : array [0..14] of boolean;
    FDB            : PCDBDynamicConn;
    FABOID         : Integer;
    m_blTrueDate   : Boolean;
    m_nDayCount    : Integer;
    function  DeleteSpaces(str :string) : string;
    procedure CreateGlobalValues(MID : integer);
    procedure GetAllowTarifs(VMID : integer);
  public
    { Public declarations }
    KindEnergy   : integer;
    FirstSign    : string;
    ThirdSign    : string;
    SecondSign   : string;
    WorksName    : string;
    Telephon     : string;
    EMail        : string;
    NameObject   : string;
    Adress       : string;
    m_strObjCode : string;
    procedure OnFormResize;
    procedure SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
    procedure PrintPreview(Date : TDateTime);
    procedure PrepareTable;
  public
    property PsgGrid     :PTAdvStringGrid  read FsgGrid      write FsgGrid;
    property prGroupID   :integer read GroupID write GroupID;
    property PDB         :PCDBDynamicConn  read FDB          write FDB;
    property PABOID      :Integer          read FABOID       write FABOID;
  end;

var
  rpPokMeters: TrpPokMeters;
  //FsgGrid    : ^TAdvStringGrid;
implementation

const
  strEnergy   : array [0..3] of string = ('Вид энергии : Активная потребляемая(кВт*ч)',
                                          'Вид энергии : Активная генерируемая(кВт*ч)',
                                          'Вид энергии : Реактивная потребляемая(кВар*ч)',
                                          'Вид энергии : Реактивная отдаваемая(кВар*ч)');

{$R *.DFM}

function  TrpPokMeters.DeleteSpaces(str :string) : string;
begin
   while str[Length(str)] = ' ' do
     SetLength(str, Length(str) - 1);
   Result := str;
end;

procedure TrpPokMeters.PrepareTable;
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
//   FDB.GetMetersAll(Meters)

   if not FDB.GetMeterGLVTableForReport(FABOID,GroupID,0, Meters) then
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
procedure TrpPokMeters.SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
Var
    i : Integer;
Begin
    for i:=0 to sgGrid.RowCount-1 do Begin sgGrid.Cells[0,i+1] := IntToStr(i+1); sgGrid.RowHeights[i]:= nHigth;End;
End;
procedure TrpPokMeters.OnFormResize;
Var
    i : Integer;
Begin
    if FsgGrid=Nil then exit;
    for i:=1 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1));
    //PChild.OnFormResize;
End;
procedure TrpPokMeters.PrintPreview(Date : TDateTime);
begin
   //FsgGrid   := @pTable;
   DateReport  := Date;
   frReport1.ShowReport;
end;

procedure TrpPokMeters.CreateGlobalValues(MID : integer);
var DataCurr            : L3CURRENTDATAS;
    i,nTypeID,swPLID    : integer;
    Sum                 : extended;
    Year,Month,Day:Word;
    nTypeEn : Byte;
begin
   Sum := 0;
   globalTblName  := FsgGrid.Cells[1, MID];
   globalTblMeter := FsgGrid.Cells[2, MID];
   glKoef         := StrToFloat(FsgGrid.Cells[3, MID]);
   m_ID           := StrToInt(FsgGrid.Cells[0, MID]);

   nTypeEn:= QRY_ENERGY_SUM_EP;
   FDB.GetMeterType(m_ID,nTypeID,swPLID);
   if nTypeID=MET_PULCR then  nTypeEn:= QRY_SUM_RASH_V;

   for i := 0 to 4 do
     globalT[i] := '0.0';
   if not FDB.GetTariffData(StrToInt(FsgGrid.Cells[0, MID]), nTypeEn, DataCurr) then
      for i := 0 to 4 do
        globalT[i] := 'Н/Д'
   else
   begin
     GetAllowTarifs(StrToInt(FsgGrid.Cells[0, MID]));
     for i := 0 to DataCurr.Count - 1 do
     begin
      m_blTrueDate := True;
      m_nDayCount := abs(trunc(Now-DataCurr.Items[i].m_sTime));
      DecodeDate(DataCurr.Items[i].m_sTime,Year,Month,Day);
      if (Year=2012)and(Month=12)and(Day=12) then
      m_blTrueDate := False;

      //if trunc(Now-DataCurr.Items[i].m_sTime)=0 then
      //m_blTrueDate := True;

       if (DataCurr.Items[i].m_swTID > 0) and (DataCurr.Items[i].m_swTID <= 4) then  //по трем тарифам
         if (globalIsTInS[DataCurr.Items[i].m_swTID]) then
           globalT[DataCurr.Items[i].m_swTID] := FloatToStr(RVLPr(DataCurr.Items[i].m_sfValue/glKoef, MeterPrecision[m_ID]))
         else
           globalT[DataCurr.Items[i].m_swTID] := '0';
       if (DataCurr.Items[i].m_swTID > 0) and (DataCurr.Items[i].m_swTID <= 4) then
         if globalIsTInS[DataCurr.Items[i].m_swTID] then
           if (DataCurr.Items[i].m_swTID > 0)and (DataCurr.Items[i].m_swTID <= 3)then
           Sum := Sum + DataCurr.Items[i].m_sfValue/glKoef
           else Sum := Sum;
     end;
     globalT[0] := FloatToStr(RVLPr(Sum, MeterPrecision[m_ID]));
   end;
end;

procedure TrpPokMeters.frReport1ManualBuild(Page: TfrPage);
var i                : integer;
    Month, Year, Day : word;
    tTime : TDateTime;
begin
   //DecodeDate(DateReport, Year, Month, Day);
   DecodeDate(Now, Year, Month, Day);
   tTime := Now;
   FDB.GetCurrentTimeData(FABOID,tTime);
   globalTitleKPD := 'Отчет о текущих показаниях электроэнергии на ' + TimeToStr(tTime)+'  '+DateToStr(tTime);
                     //cDateTimeR.GetNameMonth(Month)+ ' ' + IntToStr(Year) + ' года';
   Page.ShowBandByType({'PageHeader1'}btReportTitle);
   for i := 1 to FsgGrid.RowCount - 1 do
   begin
     CreateGlobalValues(i);
     Page.ShowBandByName('MasterData1');
   end;
   //FsgGrid := nil;
   if FsgGrid.RowCount>1 then
   Page.ShowBandByName('PageFooter1');
end;

procedure TrpPokMeters.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin
   if ParName = 'WorksName'  then ParValue := WorksName;
   if ParName = 'Telephon'   then ParValue := Telephon;
   if ParName = 'EMail'      then ParValue := EMail;
   if ParName = 'FirstSign'  then ParValue := FirstSign;
   if ParName = 'SecondSign' then ParValue := SecondSign;
   if ParName = 'ThirdSign'   then ParValue := ThirdSign;
   if ParName = 'TitleKPD'   then ParValue := globalTitleKPD;
   if ParName = 'KindEnergy' then ParValue := strEnergy[KindEnergy];
   if ParName = 'TblName'    then ParValue := globalTblName;
   if ParName = 'TblMeter'   then ParValue := globalTblMeter;
   if ParName = 'T1'         then Begin if (m_blTrueDate=True) then ParValue := globalT[1] else ParValue := '-';End;
   if ParName = 'T2'         then Begin if (m_blTrueDate=True) then ParValue := globalT[2] else ParValue := '-';End;
   if ParName = 'T3'         then Begin if (m_blTrueDate=True) then ParValue := globalT[3] else ParValue := '-';End;
   if ParName = 'T4'         then Begin if (m_blTrueDate=True) then ParValue := globalT[4] else ParValue := '-';End;
   if ParName = 'SumT'       then Begin if (m_blTrueDate=True) then ParValue := globalT[0] else ParValue := '-';End;
   if ParName = 'KoefTs'     then Begin if (m_blTrueDate=True) then ParValue := DVLSEx(glKoef, glKoef) else ParValue := '-';End;
   if ParName = 'm_strObjCode'then Parvalue := m_strObjCode;
   if ParName = 'NameObject'     then begin ParValue := NameObject; exit; end;
   if ParName = 'Adress'         then begin ParValue := Adress; exit; end;

end;
procedure TrpPokMeters.GetAllowTarifs(VMID : integer);
var tmpBuf : array of integer;
    tmpStr : string;
    TID, i : integer;
begin
   tmpStr := FDB.GetTariffString(VMID);
   SetLength(tmpBuf, Length(tmpStr) + 10);
   GetIntArrayFromStr(tmpStr, tmpBuf);
   for TID := 0 to Length(globalIsTInS) do
     globalIsTInS[TID] := false;
   for TID := 0 to Length(globalIsTInS) do
     for i := 0 to Length(tmpBuf) do
       if tmpBuf[i] = TID then
         globalIsTInS[TID] := true;
end;

{
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
 if (m_nGM.Items[(ARow-1)] and (sh shl (ACol-1)))<>0 then ABrush.Color := $0080FF00 else
      if (m_nGM.Items[(ARow-1)] and (sh shl (ACol-1)))= 0 then ABrush.Color := $008080ff;
}
procedure TrpPokMeters.frReport1EnterRect(Memo: TStringList;
  View: TfrView);
begin
   if (View.Name = 'Memo18') or
      (View.Name = 'Memo20') or
      (View.Name = 'Memo21') or
      (View.Name = 'Memo22') or
      (View.Name = 'Memo23') or
      (View.Name = 'Memo24') or
      (View.Name = 'Memo25') or
      (View.Name = 'Memo4')  then
   Begin
    //if (m_blTrueDate=False)
    // then View.FillColor := $008080ff else
     //View.FillColor := $00FFFF80;
    if m_nDayCount=0 then View.FillColor := clWhite else
    if (m_nDayCount>=1)and(m_nDayCount<=3) then View.FillColor := $00FFFF else
    if (m_nDayCount>3)or(m_blTrueDate=False) then View.FillColor := $008080ff;
   End;
end;

end.


