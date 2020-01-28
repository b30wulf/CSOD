unit knslRPKorrTime;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FR_Desgn, FR_Class, BaseGrid, AdvGrid, utlconst, utltypes, utldatabase, utlTimeDate,
  utlbox,utlexparcer;

type
  TrpKorrTime = class(TForm)
    frReport1: TfrReport;
    frDesigner1: TfrDesigner;
    procedure frReport1ManualBuild(Page: TfrPage);
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
    procedure OnEnterRect(Memo: TStringList; View: TfrView);

  private
    { Private declarations }
    FDB               : PCDBDynamicConn;
    FsgGrid           : PTAdvStringGrid;
    glKindEn          : string;
    globalTitle       : string;
    globalMeterName   : string;
    glTable1Name      : string;
    MeterN            : string;
    VMeretName        : string;
    SumKorr           : string;
    LimKorr           : string;
    PhLimKorr         : string;
    PhAddr            : string;
    GroupID           : integer;
    DateReport        : TDateTime;
    FABOID            : Integer;
    procedure OnFormResize;
    procedure SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
    function  FindItemFromMID(MID : integer; var pTable  : SL2INITITAG) : integer;
    procedure FillReport(var Page: TfrPage);
  public
    { Public declarations }
    WorksName         : string;
    FirstSign         : string;
    SecondSign        : string;
    ThirdSign         : string;
    NDogovor          : string;
    NameObject        : string;
    Adress            : string;
    m_strObjCode      : string;
    KindEnergy        : integer;
    procedure PrepareTable;
    procedure PrintPreview;
  public
    property PsgGrid     :PTAdvStringGrid  read FsgGrid      write FsgGrid;
    property prGroupID   :integer read GroupID write GroupID;
    property PDB         :PCDBDynamicConn  read FDB          write FDB;
    property PABOID      :Integer          read FABOID       write FABOID;
  end;

var
  rpKorrTime : TrpKorrTime;
  Meters     : SL2TAGREPORTLIST;

implementation

{$R *.DFM}


procedure TrpKorrTime.SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
Var
    i : Integer;
Begin
        for i:=0 to sgGrid.RowCount-1 do Begin sgGrid.Cells[0,i+1] := IntToStr(i+1); sgGrid.RowHeights[i]:= nHigth;End;
End;

procedure TrpKorrTime.OnFormResize;
Var
    i : Integer;
Begin
    if FsgGrid=Nil then exit;
    for i:=1 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1));
    //PChild.OnFormResize;
End;

procedure TrpKorrTime.PrepareTable;
var    i      : integer;
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

procedure TrpKorrTime.PrintPreview;
begin
   glTable1Name := 'Таблица 1';
   frReport1.ShowReport;
end;

function TrpKorrTime.FindItemFromMID(MID : integer; var pTable  : SL2INITITAG) : integer;
var i : integer;
begin
   for i := 0 to pTable.m_swAmMeter - 1 do
     if pTable.m_sMeter[i].m_swMID = MID then
     begin
       Result := i;
       exit;
     end;
end;

procedure TrpKorrTime.FillReport(var Page: TfrPage);
var i, j    : integer;
    pTable  : SL2INITITAG;
begin
   FDB.GetMetersAll(pTable);
   for i := 0 to Meters.Count - 1 do
   begin
     j          := FindItemFromMID(Meters.m_sMeter[i].m_swMID, pTable);
     VMeretName := Meters.m_sMeter[i].m_sVMeterName;
     PhAddr     := pTable.m_sMeter[j].m_sddFabNum;
     SumKorr    := IntToStr(cDateTimeR.DateTimeToSec(pTable.m_sMeter[j].m_sdtSumKor));
     LimKorr    := IntToStr(cDateTimeR.DateTimeToSec(pTable.m_sMeter[j].m_sdtLimKor));
     PhLimKorr  := IntToStr(cDateTimeR.DateTimeToSec(pTable.m_sMeter[j].m_sdtPhLimKor));
     Page.ShowBandByName('MasterData2');
   end;

end;

procedure TrpKorrTime.frReport1ManualBuild(Page: TfrPage);
begin
   globalTitle := 'Отчет о суммарной коррекции времени в счетчиках';
   Page.ShowBandByType(btReportTitle);
   Page.ShowBandByName('MasterData1');
   FillReport(Page);
   Page.ShowBandByName('PageFooter1');
end;

procedure TrpKorrTime.frReport1GetValue(const ParName: String;
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
   if ParName = 'VMeretName'    then ParValue := VMeretName;
   if ParName = 'SumKorr'       then ParValue := SumKorr;
   if ParName = 'LimKorr'       then ParValue := LimKorr;
   if ParName = 'PhLimKorr'     then ParValue := PhLimKorr;
   if ParName = 'PhAddr'        then ParValue := PhAddr;

end;

procedure TrpKorrTime.OnEnterRect(Memo: TStringList; View: TfrView);
begin
   if View.Name='Memo2'  then View.FillColor := $00E1FFE1;
   if View.Name='Memo4'  then View.FillColor := $00E1FFE1;
   if View.Name='Memo3'  then View.FillColor := $00E1FFE1;
   if View.Name='Memo11' then View.FillColor := $00E1FFE1;
   if View.Name='Memo13' then View.FillColor := $00E1FFE1;
end;

end.
