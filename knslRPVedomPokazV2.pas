unit knslRPVedomPokazV2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FR_Class, FR_Desgn, BaseGrid, AdvGrid, utlconst, utltypes, utldatabase, utlTimeDate,
  utlbox,utlexparcer;

type
  TRPVedomPokazV2 = class(TForm)
    frReport1: TfrReport;
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
    procedure frReport1ManualBuild(Page: TfrPage);
    procedure frReport1EnterRect(Memo: TStringList; View: TfrView);
  private
    { Private declarations }
    blViewAll            : boolean;
    blNotEqual           : boolean;
    FDB                  : PCDBDynamicConn;
    FsgGrid              : PTAdvStringGrid;
    FABOID               : Integer;
    GroupID              : integer;
    dt1, dt2             : TDateTime;
    L2AdvDiscr           : SL2TAGADVSTRUCT;
    glDateReport         : string;
    glObjName            : string;
    glObjNum             : string;
    glNaprVvoda          : string;
    glN                  : string;
    glTT                 : string;
    glTU                 : string;
    glMeterNum           : string;
    glMeterType          : string;
    glDateInst           : string;
    glKTT                : string;
    glKTU                : string;
    glKT                 : string;
    glTypeIzmr           : string;
    glDateBeg            : string;
    glDateEnd            : string;
    glIzmBeg             : string;
    glIzmEnd             : string;
    glRasxPok            : string;
    glRasxSl             : string;
    glDostover           : string;
    glMeterName          : string;
    m_AbonentAddress  : String;
    m_ContractNumber  : String;
    procedure OnFormResize;
    procedure SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
    procedure BuildReport(var Page: TfrPage);
    function  FindColSlicesFromMask(Mask : int64) : integer;
    procedure GetMeterInfo(VMID: integer);
    procedure GetPokMetersInfo(GridNote, KindEn: integer);
    procedure GetSlicesInfo(GridNote, KindEn: integer);
  public
    { Public declarations }
    KindEnergy           : integer;
    m_nRow               : Integer;
    m_nCol               : Integer;
    m_strObjCode         : string;
    procedure PrepareTable();
    procedure PrintPreview(dt_beg, dt_end : TDateTime);
    procedure OnClickVedom(ARow, ACol: Integer);
    function GetMeterTypeAlias(_Name : String):String;
  public
    property AbonentAddress  : String read m_AbonentAddress write m_AbonentAddress;
    property ContractNumber  : String read m_ContractNumber write m_ContractNumber;
    property PsgGrid     : PTAdvStringGrid  read FsgGrid      write FsgGrid;
    property prGroupID   : integer          read GroupID      write GroupID;
    property PDB         : PCDBDynamicConn  read FDB          write FDB;
    property PABOID      : Integer          read FABOID       write FABOID;
  end;

var
  f_RPVedomPokazV2: TRPVedomPokazV2;
const
  EnergName : array [0..3] of string = (
                                         'Wp+',
                                         'Wp-',
                                         'Wq+',
                                         'Wq-'
                                        );

implementation

{$R *.DFM}

procedure TRPVedomPokazV2.SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
Var
    i : Integer;
Begin
    for i:=0 to sgGrid.RowCount-1 do Begin sgGrid.Cells[0,i+1] := IntToStr(i+1); sgGrid.RowHeights[i]:= nHigth;End;
End;

procedure TRPVedomPokazV2.OnFormResize;
Var
    i : Integer;
Begin
    if FsgGrid=Nil then exit;
    for i:=1 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1));
    //PChild.OnFormResize;
End;

procedure TRPVedomPokazV2.PrepareTable;
var Meters : SL2TAGREPORTLIST;
    i,j    : integer;
begin
   if FsgGrid=Nil then exit;
   m_nCol := -1;
   m_nRow := -1;
   FsgGrid.ColCount      := 5;
   FsgGrid.RowCount      := 60;
   FsgGrid.Cells[0,0]    := '№ п.п';
   FsgGrid.Cells[1,0]    := 'Наименование учета';
   FsgGrid.Cells[2,0]    := 'Номер счетчика';
   FsgGrid.Cells[3,0]    := 'Коэффициент';
   FsgGrid.Cells[4,0]    := 'Тип счетчика';
   FsgGrid.ColWidths[0]  := 30;
   SetHigthGrid(FsgGrid^,20);
   //if not FDB.GetMeterTableForReport(FABOID,GroupID, Meters) then
   if not FDB.GetMeterGLVTableForReport(FABOID,GroupID,0, Meters) then
   FsgGrid.RowCount := 1
   else
   begin
     j := 0;
     FsgGrid.RowCount := Meters.Count+1;
     for i := 0 to Meters.Count - 1 do
     begin
       if (Meters.m_sMeter[i].m_sbyType = MET_VZLJOT) or (Meters.m_sMeter[i].m_sbyType = MET_SUMM)
       or (Meters.m_sMeter[i].m_sbyType = MET_GSUMM) then
       continue else Begin j:=j+1;FsgGrid.RowCount:=j+1;End;
       FsgGrid.Cells[0,j] := IntToStr(Meters.m_sMeter[i].m_swVMID);
       FsgGrid.Cells[1,j] := Meters.m_sMeter[i].m_sVMeterName;
       FsgGrid.Cells[2,j] := Meters.m_sMeter[i].m_sddPHAddres;
       FsgGrid.Cells[3,j] := DVLS(Meters.m_sMeter[i].m_sfKI*Meters.m_sMeter[i].m_sfKU);
       FsgGrid.Cells[4,j] := Meters.m_sMeter[i].m_sName;
     end;
   end;
   OnFormResize;
end;

procedure TRPVedomPokazV2.PrintPreview(dt_beg, dt_end : TDateTime);
begin
   if FsgGrid.RowCount = 1 then
     exit;
   glDateReport := '';
   glObjName    := '';
   glObjNum     := '';
   glNaprVvoda  := '';
   glN          := '';
   glTT         := '';
   glTU         := '';
   glMeterNum   := '';
   glMeterType  := '';
   glDateInst   := '';
   glKTT        := '';
   glKTU        := '';
   glKT         := '';
   glTypeIzmr   := '';
   glDateBeg    := '';
   glDateEnd    := '';
   glIzmBeg     := '';
   glIzmEnd     := '';
   glRasxPok    := '';
   glRasxSl     := '';
   glDostover   := '';
   glMeterName  := '';
   dt1          := dt_beg;
   dt2          := dt_end;
   frReport1.ShowReport;
end;

function  TRPVedomPokazV2.FindColSlicesFromMask(Mask : int64) : integer;
var i : integer;
begin
   Result := 0;
   for i := 0 to 47 do
     if IsBitInMask(Mask, i) then
       Result := Result + 1;
end;

procedure TRPVedomPokazV2.GetMeterInfo(VMID: integer);
var MeterInfo : SL2TAG;
begin
   if PDB.GetMMeterTable(VMID, MeterInfo) then
   begin
     GetL2AdvStructFromStr(MeterInfo.m_sAdvDiscL2Tag, L2AdvDiscr);
     glMeterNum := MeterInfo.m_sddFabNum;
     glKTT      := FloatToStr(MeterInfo.m_sfKI);
     glKTU      := FloatToStr(MeterInfo.m_sfKU);
     glKT       := FloatToStr(MeterInfo.m_sfKI * MeterInfo.m_sfKU);
   end;
end;

procedure TRPVedomPokazV2.GetPokMetersInfo(GridNote, KindEn: integer);
var pTable : CCDatasEkom;
    KT     : double;
begin
   KT := StrToFloat(FSGGrid.Cells[3, GridNote]);
   if (PDB.GetEKOM3000GData(dt2, dt1, StrToInt(FsgGrid.Cells[0, GridNote]),  StrToInt(FsgGrid.Cells[0, GridNote]),
                        QRY_NAK_EN_DAY_EP + KindEn, QRY_NAK_EN_DAY_EP + KindEn, pTable)=False) then
   PDB.GetEKOM3000GData(dt2, dt1, StrToInt(FsgGrid.Cells[0, GridNote]),  StrToInt(FsgGrid.Cells[0, GridNote]),
                        QRY_NAK_EN_MONTH_EP + KindEn, QRY_NAK_EN_MONTH_EP + KindEn, pTable);

   if (pTable.Count > 0) and (trunc(pTable.Items[0].m_sTime) = trunc(dt1)) then
     glIzmBeg := FloatToStrF(RVL(pTable.Items[0].m_sfValue/KT), ffFixed, 18, MeterPrecision[StrToInt(FsgGrid.Cells[0, GridNote])])
   else
     glIzmBeg := '-';
   if (pTable.Count > 0) and (trunc(pTable.Items[pTable.Count - 1].m_sTime) = trunc(dt2)) then
     glIzmEnd := FloatToStrF(RVL(pTable.Items[pTable.Count - 1].m_sfValue/KT), ffFixed, 18, MeterPrecision[StrToInt(FsgGrid.Cells[0, GridNote])])
   else
     glIzmEnd := '-';
   if (glIzmBeg <> '-') and (glIzmEnd <> '-') then
     glRasxPok := FloatToStrF(RVL(pTable.Items[pTable.Count - 1].m_sfValue - pTable.Items[0].m_sfValue), ffFixed, 18, MeterPrecision[StrToInt(FsgGrid.Cells[0, GridNote])])
   else
     glRasxPok := '-';
end;

procedure TRPVedomPokazV2.GetSlicesInfo(GridNote, KindEn: integer);
var pTable              : L3GRAPHDATAS;
    KT, SumEn, Perc,nPok     : extended;
    i, j, NumSl, MaxSlN : integer;
begin
   KT := StrToFloat(FSGGrid.Cells[3, GridNote]);
   PDB.GetGraphDatas(dt2 - 1, dt1, StrToInt(FsgGrid.Cells[0, GridNote]), QRY_SRES_ENR_EP + KindEn, pTable);
   SumEn := 0;
   NumSl := 0;
   MaxSlN := trunc(dt2 - dt1)*48;
   for i := 0 to pTable.Count - 1 do
   begin
     NumSl := NumSl + FindColSlicesFromMask(pTable.Items[i].m_sMaskRead);
     for j := 0 to 47 do
       SumEn := SumEn + pTable.Items[i].v[j];
   end;
   if MaxSlN <> 0 then
     Perc := NumSl / MaxSlN
   else
     Perc := 0;

   if Perc > 1 then
     Perc := 1;
   glDostover := IntToStr(trunc(Perc*100));

   {
   if (glRasxPok<>'-')and(SumEn<>0) then
   Begin
    nPok := StrToFloat(glRasxPok);
    if abs(SumEn-nPok)<=0.5 then SumEn:=nPok;
   End;
   }
   glRasxSl   := FloatToStrF(RVL(SumEn), ffFixed, 18, MeterPrecision[StrToInt(FsgGrid.Cells[0, GridNote])])
end;
procedure TRPVedomPokazV2.OnClickVedom(ARow, ACol: Integer);
Begin
    m_nCol := -1;
    m_nRow := -1;
    if (ARow<>0)and(ACol<>0) then
    Begin
     m_nCol := ACol;
     m_nRow := ARow;
    End;
End;
procedure TRPVedomPokazV2.BuildReport(var Page: TfrPage);
var i, KindEn, PtToCut, MeterB, MeterE : integer;
begin
   if (GroupID=-1)and(m_nRow<>-1) then
   begin
     if (FsgGrid.Row = 0)or(FsgGrid.Cells[0, FsgGrid.Row]='') then exit;
     MeterB := FsgGrid.Row;
     MeterE := FsgGrid.Row;
   end
   else
   begin
     MeterB := 1;
     MeterE := FSGGrid.RowCount - 1;
   end;
   for i := MeterB to MeterE do
   begin
     PtToCut := 1;
     glN := IntToStr(i);
     glMeterType := GetMeterTypeAlias(FSGGrid.Cells[4, i]);
     GetMeterInfo(StrToInt(FSGGrid.Cells[0, i]));
     for KindEn := 0 to 3 do
     begin
       if PtToCut <= Length(FSGGrid.Cells[1, i]) then
       begin
         glMeterName := Copy(FSGGrid.Cells[1, i], PtToCut, 28);
         PtToCut := PtToCut + 28;
       end else glMeterName := '';
       glTypeIzmr := EnergName[KindEn];
       GetPokMetersInfo(i, KindEn);
       GetSlicesInfo(i, KindEn);
       if KindEn = 0 then
         blViewAll := true
       else
         blViewAll := false;
       if glRasxPok <> glRasxSl then
         blNotEqual := true
       else
         blNotEqual := false;
       Page.ShowBandByName('MasterData1');
     end;
   end;
end;

procedure TRPVedomPokazV2.frReport1ManualBuild(Page: TfrPage);
var AbonInfo : SL3ABONS;
begin
   PDB.GetAbonTable(FABOID, AbonInfo);
   if AbonInfo.Count <> 0 then
   begin
     glObjName := AbonInfo.Items[0].m_sName;
     glObjNum  := AbonInfo.Items[0].m_sObject;
   end;
   glDateReport := 'с ' + DateToStr(dt1) + ' по ' + DateToStr(dt2);
   glDateBeg    := DateToStr(dt1);
   glDateEnd    := DateToStr(dt2);
   //Page.ShowBandByName('PageHeader1');
   BuildReport(Page);
   //Page.ShowBandByName('MasterData1');
end;
procedure TRPVedomPokazV2.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin
   if ParName = 'DateReport' then ParValue := glDateReport;
   if ParName = 'ObjName'    then ParValue := glObjName;
   if ParName = 'AbonentAddress'    then ParValue := m_AbonentAddress;
   if ParName = 'Contract'    then ParValue := m_ContractNumber;
   if ParName = 'ObjNum'     then ParValue := glObjNum;
   if ParName = 'NaprVvoda'  then ParValue := L2AdvDiscr.m_sNaprVvoda;
   if ParName = 'N'          then ParValue := glN;
   if ParName = 'TT'         then ParValue := L2AdvDiscr.m_sTypeTI;
   if ParName = 'TU'         then ParValue := L2AdvDiscr.m_sTypeTU;
   if ParName = 'MeterNum'   then ParValue := glMeterNum;
   if ParName = 'MeterType'  then ParValue := glMeterType;
   if ParName = 'DateInst'   then ParValue := DateToStr(L2AdvDiscr.m_sDateInst);
   if ParName = 'KTI'        then ParValue := glKTT;
   if ParName = 'KTU'        then ParValue := glKTU;
   if ParName = 'KTE'         then ParValue := glKT;
   if ParName = 'TypeIzmr'   then ParValue := glTypeIzmr;
   if ParName = 'DateBeg'    then ParValue := glDateBeg;
   if ParName = 'DateEnd'    then ParValue := glDateEnd;
   if ParName = 'IzmBeg'     then ParValue := glIzmBeg;
   if ParName = 'IzmEnd'     then ParValue := glIzmEnd;
   if ParName = 'RasxPok'    then ParValue := glRasxPok;
   if ParName = 'RasxSl'     then ParValue := glRasxSl;
   if ParName = 'Dostover'   then ParValue := glDostover;
   if ParName = 'MeterName'  then ParValue := glMeterName;
   if ParName = 'LostPercent'  then ParValue := 0;   
   if ParName = 'm_strObjCode'then Parvalue := m_strObjCode;
end;

procedure TRPVedomPokazV2.frReport1EnterRect(Memo: TStringList;
  View: TfrView);
begin
   if not blViewAll then
   begin
     if (View.Name = 'Memo31') or (View.Name = 'Memo32') {or (View.Name = 'Memo53')} or
        (View.Name = 'Memo33') or (View.Name = 'Memo34') or (View.Name = 'Memo35') or
        (View.Name = 'Memo36') or (View.Name = 'Memo37') or (View.Name = 'Memo38') or
        (View.Name = 'Memo39') or (View.Name = 'Memo40') or (View.Name = 'Memo41') or
        (View.Name = 'Memo42') then
       View.Visible := false
   end
   else
     View.Visible := true;
   if View.Name = 'Memo47' then
     if blNotEqual then
       View.FillColor := $00ffbdf3
     else
       View.FillColor := clWhite;
end;

function TRPVedomPokazV2.GetMeterTypeAlias(_Name : String):String;
begin
  if (_Name = 'SS301F3') or (_Name = 'SS301F4') then
    Result := 'CC-301';
end;

end.
