unit knslRPGomelBalans;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FR_Desgn, FR_Class, RbDrawCore, RbButton, AdvPanel, ExtCtrls,
  AdvGlowButton, StdCtrls, Grids, BaseGrid, AdvGrid, utlconst, utltypes, utldatabase, utlTimeDate,
  utlbox,utlexparcer, ComCtrls, AdvAppStyler, GradientLabel;

type
  TRPGomelBalans = class(TForm)
    frDesigner1: TfrDesigner;
    AdvPanel2: TAdvPanel;
    frReport1: TfrReport;
    sgGroups: TAdvStringGrid;
    sgBalansVM: TAdvStringGrid;
    AdvGlowButton1: TAdvGlowButton;
    AdvGlowButton2: TAdvGlowButton;
    ReportFormStyler1: TAdvFormStyler;
    ReportPanelStyler: TAdvPanelStyler;
    sgCalcVM: TAdvStringGrid;
    Panel5: TAdvPanel;
    rbCreateReport: TRbButton;
    btnCancel: TRbButton;
    AdvPanel1: TAdvPanel;
    Label5: TLabel;
    Label4: TLabel;
    dtBegin: TDateTimePicker;
    dtEnd: TDateTimePicker;
    GradientLabel: TGradientLabel;
    GradientLabel1: TGradientLabel;
    GradientLabel2: TGradientLabel;
    procedure btnCancelClick(Sender: TObject);
    procedure rbCreateReportClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sgGroupsDblClick(Sender: TObject);
    procedure AdvGlowButton1Click(Sender: TObject);
    procedure AdvGlowButton2Click(Sender: TObject);
    procedure frReport1ManualBuild(Page: TfrPage);
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
  private
    { Private declarations }
    strKindEnAll             : string;
    globalMeterName          : string;
    glTarNames               : array [1..3] of string;
    MeterN                   : string;
    glPokEnergB              : string;
    glPokEnergE              : string;
    KindEn                   : string;
    glKoef                   : Double;
    glEnergRasx              : array [0..4] of Double;
    glEnergS                 : array [0..4] of Double;
    glEnergBal               : array [0..4] of Double;
    glEnergCal               : array [0..4] of Double;
    MaxPB, MaxPC             : array [0..4] of Double;
    MaxBInd, MaxCInd         : array [0..4] of Integer;
    pDblClDir                : byte;
    FDB                      : PCDBDynamicConn;
    FABOID                   : integer;
    BalansGrID, CalcGrID     : integer;
    BalansVM, CalcVM         : SL2TAGREPORTLIST;
    GrTable                  : SL3INITTAG;
    m_pTarBal_E, m_pTarCal_E : TM_TARIFFS;
    m_pTarBal_P, m_pTarCal_P : TM_TARIFFS;
    SBufBal, SBufCal         : array of Double;
    sExprBal, sExprCal       : string;
    Fm_nEVL                  : CEvaluator;
    function  FindTarName(TID : integer; var TarDisc : TM_TARIFFS): string;
    function  GetColorFromTariffs(Srez:byte; var pTable:TM_TARIFFS):Byte;
    procedure FillFormula(VMID : integer; Value : Double);
    function  FindItemFromGroups(GrID : integer): integer;
    function  FindItemFromSL3VMeters(VMID : integer; var pTable: SL2TAGREPORTLIST) : integer;
    procedure FillRasxBalans(var SlBuf : array of Double; var Page: TfrPage);
    procedure FillRasxCal(var SlBuf : array of Double; var Page: TfrPage);
    procedure ReadSlicesBal(var Page: TfrPage);
    procedure ReadSlicesCal(var Page: TfrPage);
    procedure FillTotalRasx(var Page: TfrPage);
    procedure FindMax(var Page: TfrPage);
    procedure LoadGroupsToSG;
    procedure LoadVMToBalansSG(GrID : integer);
    procedure LoadVMToCalcSG(GrID : integer);
    function  GetDateStrFrInd(ind: integer): String;
  public
    { Public declarations }
    WorksName            : string;
    FirstSign            : string;
    SecondSign           : string;
    ThirdSign            : string;
    NDogovor             : string;
    property PDB         : PCDBDynamicConn  read FDB          write FDB;
    property PABOID      : integer          read FABOID       write FABOID;
    property Pm_nEVL     : CEvaluator       read fm_nEVL      write fm_nEVL;

  end;

var
  RPGomelBalans: TRPGomelBalans;

implementation
uses knsl3report;

{$R *.DFM}

procedure TRPGomelBalans.btnCancelClick(Sender: TObject);
begin
   Close;
end;

procedure TRPGomelBalans.rbCreateReportClick(Sender: TObject);
begin
   if (sgBalansVM.Cells[0, 1] ='') or (sgCalcVM.Cells[0, 1] ='') then
   begin
     MessageDlg('Введены не все данные, требуемые для построения отчета!', mtWarning, [mbOk,mbCancel], 0);
     exit;
   end;
   frReport1.ShowReport;
   Close;
end;

function TRPGomelBalans.FindTarName(TID : integer; var TarDisc : TM_TARIFFS): string;
var i: integer;
begin
   Result := 'Тариф не определен';
   for i := 0 to TarDisc.Count - 1 do
     if TarDisc.Items[i].m_swTID = TID then
     begin
       Result := TarDisc.Items[i].m_sName;
       exit;
     end;
end;

function TRPGomelBalans.GetColorFromTariffs(Srez:byte; var pTable:TM_TARIFFS):Byte;
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

procedure TRPGomelBalans.FillFormula(VMID : integer; Value : Double);
begin
   Fm_nEVL.Variable['v' + IntToStr(VMID) + '_P'] := Value;
end;

function TRPGomelBalans.FindItemFromGroups(GrID : integer): integer;
var i : integer;
begin
   Result := 0;
   for i := 0 to GrTable.Count - 1 do
     if GrTable.Items[i].m_sbyGroupID = GrID then
     begin
       Result := i;
       break;
     end;
end;

function TRPGomelBalans.FindItemFromSL3VMeters(VMID : integer; var pTable: SL2TAGREPORTLIST) : integer;
var i : integer;
begin
   Result := 0;
   for i := 0 to pTable.Count - 1 do
     if pTable.m_sMeter[i].m_swVMID = VMID then
     begin
       Result := i;
       break;
     end;
end;

procedure TRPGomelBalans.LoadVMToBalansSG(GrID : integer);
var i  : integer;
begin
   FDB.GetMeterTableForReport(FABOID, GrID, BalansVM);
   //sgBalansVM.RowCount := 2;
   BalansGrID := GrID;
   if sgBalansVM.RowCount=1 then sExprBal   := GrTable.Items[FindItemFromGroups(GrID)].m_sGroupExpress else
   if sgBalansVM.RowCount>1 then sExprBal   := sExprBal+' + '+GrTable.Items[FindItemFromGroups(GrID)].m_sGroupExpress;
   for i := 0 to BalansVM.Count - 1 do
   begin
     sgBalansVM.Cells[0, sgBalansVM.RowCount - 0] := IntToStr(BalansVM.m_sMeter[i].m_swVMID);
     sgBalansVM.Cells[1, sgBalansVM.RowCount - 0] := BalansVM.m_sMeter[i].m_sVMeterName;
     sgBalansVM.Cells[2, sgBalansVM.RowCount - 0] := BalansVM.m_sMeter[i].m_sddPHAddres;
     sgBalansVM.RowCount := sgBalansVM.RowCount + 1;
   end;
   if sgBalansVM.RowCount > 2 then
     sgBalansVM.RowCount := sgBalansVM.RowCount - 0;
end;

procedure TRPGomelBalans.LoadVMToCalcSG(GrID : integer);
var i : integer;
begin
   FDB.GetMeterTableForReport(FABOID, GrID, CalcVM);
   sgCalcVM.RowCount := 2;
   CalcGrID := GrID;
   sExprCal := GrTable.Items[FindItemFromGroups(GrID)].m_sGroupExpress;
   for i := 0 to CalcVM.Count - 1 do
   begin
     sgCalcVM.Cells[0, sgCalcVM.RowCount - 1] := IntToStr(CalcVM.m_sMeter[i].m_swVMID);
     sgCalcVM.Cells[1, sgCalcVM.RowCount - 1] := CalcVM.m_sMeter[i].m_sVMeterName;
     sgCalcVM.Cells[2, sgCalcVM.RowCount - 1] := CalcVM.m_sMeter[i].m_sddPHAddres;
     sgCalcVM.RowCount := sgCalcVM.RowCount + 1;
   end;
   if sgCalcVM.RowCount > 2 then
     sgCalcVM.RowCount := sgCalcVM.RowCount - 1;
end;

procedure TRPGomelBalans.LoadGroupsToSG;
var i      : integer;
begin
   sgGroups.RowCount := 2;
   FDB.GetAbonGroupsTable(FABOID, GrTable);
   for i := 0 to GrTable.Count - 1 do
   begin
     if GrTable.Items[i].m_nGroupLV <> 0 then
       continue;
     sgGroups.Cells[0, sgGroups.RowCount  - 1] := IntToStr(GrTable.Items[i].m_sbyGroupID);
     sgGroups.Cells[1, sgGroups.RowCount  - 1] := GrTable.Items[i].m_sGroupName;
     sgGroups.RowCount := sgGroups.RowCount + 1;
   end;
   if sgGroups.RowCount > 2 then
     sgGroups.RowCount := sgGroups.RowCount - 1; 
end;

procedure TRPGomelBalans.FormShow(Sender: TObject);
begin
   dtBegin.DateTime        := Now;
   dtEnd.DateTime          := Now;
   pDblClDir               := 0;
   LoadGroupsToSG;
   sgBalansVM.RowCount := 1;
   sExprBal   := '';

end;

procedure TRPGomelBalans.sgGroupsDblClick(Sender: TObject);
begin
   {
   if (sgGroups.Row = 0) or (sgGroups.Row >= sgGroups.RowCount) or
      (sgGroups.Cells[0, sgGroups.Row] = '') then
     exit;
   case pDblClDir of
     0 : LoadVMToBalansSG(StrToInt(sgGroups.Cells[0, sgGroups.Row]));
     1 : LoadVMToCalcSG(StrToInt(sgGroups.Cells[0, sgGroups.Row]));
   end;
   pDblClDir := pDblClDir xor $01;
   }
end;

procedure TRPGomelBalans.AdvGlowButton1Click(Sender: TObject);
begin
   if (sgGroups.Row = 0) or (sgGroups.Row >= sgGroups.RowCount) or
      (sgGroups.Cells[0, sgGroups.Row] = '') then
     exit;
   LoadVMToBalansSG(StrToInt(sgGroups.Cells[0, sgGroups.Row]));
end;

procedure TRPGomelBalans.AdvGlowButton2Click(Sender: TObject);
begin
   if (sgGroups.Row = 0) or (sgGroups.Row >= sgGroups.RowCount) or
      (sgGroups.Cells[0, sgGroups.Row] = '') then
     exit;
   LoadVMToCalcSG(StrToInt(sgGroups.Cells[0, sgGroups.Row]));
end;

procedure TRPGomelBalans.FillRasxBalans(var SlBuf : array of Double; var Page: TfrPage);
var i, j, k, Index   : integer;
    DayCount, res    : integer;
    pTable           : CCDatasEkom;
    VMItem           : integer;
    BalansVM1: SL2TAGREPORTLIST;
begin
   glTarNames[1] := FindTarName(1, m_pTarBal_E);
   glTarNames[2] := FindTarName(2, m_pTarBal_E);
   glTarNames[3] := FindTarName(3, m_pTarBal_E);
   KindEn        := '1.1 Активная принимаемая (кВт*ч)';
   Page.ShowBandByName('MasterHeader1');
   DayCount := trunc(dtEnd.DateTime) - trunc(dtBegin.DateTime) + 1;
   FDB.GetMeterTableForReport(FABOID, -1, BalansVM1);
   for i := 1 to sgBalansVM.RowCount - 1 do
   begin
     globalMeterName := sgBalansVM.Cells[1, i];
     MeterN          := sgBalansVM.Cells[2, i];
     VMItem          := FindItemFromSL3VMeters(StrToInt(sgBalansVM.Cells[0, i]), BalansVM1);
     glKoef          := BalansVM1.m_sMeter[VMItem].m_sfKI*BalansVM1.m_sMeter[VMItem].m_sfKU;
     for res := 0 to 4 do
     begin
       glEnergRasx[res] := 0;
       glEnergS[res]    := 0;
     end;
     for j := 0 to DayCount - 1 do
       for k := 0 to 47 do
       begin
         Index := GetColorFromTariffs(k, m_pTarBal_E);
         glEnergRasx[Index] := glEnergRasx[Index] + SlBuf[(i-1)*(DayCount)*48 + j*48 + k];
       end;
     for res := 0 to 4 do
       glEnergRasx[res] := RVLPr(glEnergRasx[res], MeterPrecision[StrToInt(sgBalansVM.Cells[0, i])]);
     glEnergRasx[0] := RVLPr(glEnergRasx[1], MeterPrecision[StrToInt(sgBalansVM.Cells[0, i])]) + RVLPr(glEnergRasx[2], MeterPrecision[StrToInt(sgBalansVM.Cells[0, i])]) + RVLPr(glEnergRasx[3], MeterPrecision[StrToInt(sgBalansVM.Cells[0, i])]) ;
     for res := 0 to 4 do
     begin
       glEnergBal[res] := glEnergBal[res] + RVLPr(glEnergRasx[res], MeterPrecision[StrToInt(sgBalansVM.Cells[0, i])]);
      // glEnergS[res] := glEnergBal[res];
     end;
     if PDB.GetEKOM3000GData(dtEnd.DateTime + 1, dtBegin.DateTime, StrToInt(sgBalansVM.Cells[0, i]),  StrToInt(sgBalansVM.Cells[0, i]),
                        QRY_NAK_EN_DAY_EP, QRY_NAK_EN_DAY_EP, pTable)=false then
        PDB.GetEKOM3000GData(dtEnd.DateTime + 1, dtBegin.DateTime, StrToInt(sgBalansVM.Cells[0, i]),  StrToInt(sgBalansVM.Cells[0, i]),
                        QRY_NAK_EN_MONTH_EP, QRY_NAK_EN_MONTH_EP, pTable);
     if (pTable.Count > 0) and (trunc(pTable.Items[0].m_sTime) = trunc(dtBegin.DateTime)) then
       glPokEnergB := FloatToStr(RVLPr(pTable.Items[0].m_sfValue/glKoef, MeterPrecision[StrToInt(sgBalansVM.Cells[0, i])]))
     else
       glPokEnergB := '-';

     if (pTable.Count > 0) and (trunc(pTable.Items[pTable.Count - 1].m_sTime) = trunc(dtEnd.DateTime + 1)) then
       glPokEnergE := FloatToStr(RVLPr(pTable.Items[pTable.Count - 1].m_sfValue/glKoef, MeterPrecision[StrToInt(sgBalansVM.Cells[0, i])]))
     else
       glPokEnergE := '-';
     Page.ShowBandByName('MasterData1');    //Данные о потреблении
   end;
end;

procedure TRPGomelBalans.FillRasxCal(var SlBuf : array of Double; var Page: TfrPage);
var i, j, k, Index   : integer;
    DayCount, res    : integer;
    pTable           : CCDatasEkom;
    VMItem           : integer;
begin
   glTarNames[1] := FindTarName(1, m_pTarBal_E);
   glTarNames[2] := FindTarName(2, m_pTarBal_E);
   glTarNames[3] := FindTarName(3, m_pTarBal_E);
   KindEn        := '1.2 Активная отдаваемая (кВт*ч)';
   Page.ShowBandByName('MasterHeader1');
   DayCount := trunc(dtEnd.DateTime) - trunc(dtBegin.DateTime) + 1;
   for i := 0 to 4 do
   begin
      glEnergCal[i] := glEnergBal[i];
      glEnergS[i]   := 0;
   end;
   for i := 1 to sgCalcVM.RowCount - 1 do
   begin
     globalMeterName := sgCalcVM.Cells[1, i];
     MeterN          := sgCalcVM.Cells[2, i];
     VMItem          := FindItemFromSL3VMeters(StrToInt(sgCalcVM.Cells[0, i]), CalcVM);
     glKoef          := CalcVM.m_sMeter[VMItem].m_sfKI*CalcVM.m_sMeter[VMItem].m_sfKU;
     for res := 0 to 4 do
       glEnergRasx[res] := 0;
     for j := 0 to DayCount - 1 do
       for k := 0 to 47 do
       begin
         Index := GetColorFromTariffs(k, m_pTarBal_E);
         glEnergRasx[Index] := glEnergRasx[Index] + SlBuf[(i-1)*(DayCount)*48 + j*48 + k];
       end;
     for res := 0 to 4 do
       glEnergRasx[res] := RVLPr(glEnergRasx[res], MeterPrecision[StrToInt(sgCalcVM.Cells[0, i])]);
     glEnergRasx[0] := RVLPr(glEnergRasx[1], MeterPrecision[StrToInt(sgCalcVM.Cells[0, i])]) + RVLPr(glEnergRasx[2], MeterPrecision[StrToInt(sgCalcVM.Cells[0, i])]) + RVLPr(glEnergRasx[3], MeterPrecision[StrToInt(sgCalcVM.Cells[0, i])]);
     for res := 0 to 4 do
     begin
       glEnergCal[res] := glEnergCal[res] - RVLPr(glEnergRasx[res], MeterPrecision[StrToInt(sgCalcVM.Cells[0, i])]);
       glEnergS[i] := glEnergRasx[res];
     end;
     if PDB.GetEKOM3000GData(dtEnd.DateTime + 1, dtBegin.DateTime, StrToInt(sgCalcVM.Cells[0, i]),  StrToInt(sgCalcVM.Cells[0, i]),
                        QRY_NAK_EN_DAY_EP, QRY_NAK_EN_DAY_EP, pTable)=false then
        PDB.GetEKOM3000GData(dtEnd.DateTime + 1, dtBegin.DateTime, StrToInt(sgCalcVM.Cells[0, i]),  StrToInt(sgCalcVM.Cells[0, i]),
                        QRY_NAK_EN_MONTH_EP, QRY_NAK_EN_MONTH_EP, pTable);
     if (pTable.Count > 0) and (trunc(pTable.Items[0].m_sTime) = trunc(dtBegin.DateTime)) then
       glPokEnergB := FloatToStr(RVLPr(pTable.Items[0].m_sfValue/glKoef, MeterPrecision[StrToInt(sgCalcVM.Cells[0, i])]))
     else
       glPokEnergB := '-';

     if (pTable.Count > 0) and (trunc(pTable.Items[pTable.Count - 1].m_sTime) = trunc(dtEnd.DateTime + 1)) then
       glPokEnergE := FloatToStr(RVLPr(pTable.Items[pTable.Count - 1].m_sfValue/glKoef, MeterPrecision[StrToInt(sgCalcVM.Cells[0, i])]))
     else
       glPokEnergE := '-';
     //Итого Активная Энергия принимаемая
     Page.ShowBandByName('MasterData1');    //Данные о потреблении
   end;

end;

procedure TRPGomelBalans.ReadSlicesBal(var Page: TfrPage);
var i, j, k, DayCount : integer;
    SlBuf             : array of Double;
    m_pGrData         : L3GRAPHDATAS;
    Index             : Integer;
begin
   DayCount := trunc(dtEnd.DateTime) - trunc(dtBegin.DateTime) + 1;
   SetLength(SlBuf, DayCount*(sgBalansVM.RowCount - 1)*48);
   for i := 0 to Length(SlBuf) - 1 do
     SlBuf[i] := 0;
   for i := 1 to sgBalansVM.RowCount - 1 do
   begin
     if not FDB.GetGraphDatas(dtEnd.DateTime, dtBegin.DateTime, StrToInt(sgBalansVM.Cells[0, i]),
                                QRY_SRES_ENR_EP, m_pGrData) then
       continue
     else
     begin
       for j := 0 to m_pGrData.Count - 1 do
         for k := 0 to 47 do
           SlBuf[(i-1)*(DayCount)*48 + (trunc(m_pGrData.Items[j].m_sdtDate) - trunc(dtBegin.DateTime))*48 + k] := m_pGrData.Items[j].v[k];
     end;
   end;
   FillRasxBalans(SlBuf, Page);
   SetLength(SBufBal, DayCount*48);
   for i := 0 to Length(SBufBal) - 1 do
     SBufBal[i] := 0;
   for j := 0 to DayCount - 1 do
     for k := 0 to 47 do
     begin
       Fm_nEVL.Expression := sExprBal;
       for i := 1 to sgBalansVM.RowCount - 1 do
         FillFormula(StrToInt(sgBalansVM.Cells[0, i]), SlBuf[(i-1)*(DayCount)*48 + j*48 + k]);
       SBufBal[j*48 + k] := Fm_nEVL.Value;
     end;

   for i := 0 to Length(SBufBal) - 1 do
   begin
     Index := GetColorFromTariffs(i mod 48, m_pTarBal_E);
     glEnergS[Index] := glEnergS[Index] + SBufBal[i];
   end;
   glEnergS[0] := glEnergS[1] + glEnergS[2] + glEnergS[3];
   strKindEnAll := 'Итого Активная Энергия принимаемая';
   Page.ShowBandByName('MasterFooter1');
end;

procedure TRPGomelBalans.ReadSlicesCal(var Page: TfrPage);
var i, j, k, DayCount : integer;
    SlBuf             : array of Double;
    m_pGrData         : L3GRAPHDATAS;
    Index             : Integer;
begin
   DayCount := trunc(dtEnd.DateTime) - trunc(dtBegin.DateTime) + 1;
   SetLength(SlBuf, DayCount*(sgCalcVM.RowCount - 1)*48);
   for i := 0 to Length(SlBuf) - 1 do
     SlBuf[i] := 0;
   for i := 1 to sgCalcVM.RowCount - 1 do
   begin
     if not FDB.GetGraphDatas(dtEnd.DateTime, dtBegin.DateTime, StrToInt(sgCalcVM.Cells[0, i]),
                                QRY_SRES_ENR_EP, m_pGrData) then
       continue
     else
     begin
       for j := 0 to m_pGrData.Count - 1 do
         for k := 0 to 47 do
           SlBuf[(i-1)*(DayCount)*48 + (trunc(m_pGrData.Items[j].m_sdtDate) - trunc(dtBegin.DateTime))*48 + k] := m_pGrData.Items[j].v[k];
     end;
   end;
   FillRasxCal(SlBuf, Page);
   SetLength(SBufCal, DayCount*48);
   for i := 0 to Length(SBufCal) - 1 do
     SBufCal[i] := 0;
   for j := 0 to DayCount - 1 do
     for k := 0 to 47 do
     begin
       Fm_nEVL.Expression := sExprCal;
       for i := 1 to sgCalcVM.RowCount - 1 do
         FillFormula(StrToInt(sgCalcVM.Cells[0, i]), SlBuf[(i-1)*(DayCount)*48 + j*48 + k]);
       SBufCal[j*48 + k] := Fm_nEVL.Value;
     end;
   for i := 0 to Length(SBufBal) - 1 do
   begin
     Index := GetColorFromTariffs(i mod 48, m_pTarBal_E);
     glEnergS[Index] := glEnergS[Index] + SBufCal[i];
   end;
   glEnergS[0] := glEnergS[1] + glEnergS[2] + glEnergS[3];
   strKindEnAll := 'Итого Активная Энергия отдаваемая';
   Page.ShowBandByName('MasterFooter1');
end;

procedure TRPGomelBalans.FillTotalRasx(var Page: TfrPage);
var i, Index   : integer;
begin
   glTarNames[1] := FindTarName(1, m_pTarBal_E);
   glTarNames[2] := FindTarName(2, m_pTarBal_E);
   glTarNames[3] := FindTarName(3, m_pTarBal_E);
   //Page.NewPage;
   Page.ShowBandByName('MasterHeader2');
   for i := 0 to 4 do
   begin
     glEnergBal[i] := 0;
     glEnergCal[i] := 0;
   end;
   for i := 0 to Length(SBufBal) - 1 do
   begin
     Index := GetColorFromTariffs(i mod 48, m_pTarBal_E);
     glEnergBal[Index] := glEnergBal[Index] + SBufBal[i];
     glEnergCal[Index] := glEnergCal[Index] + SBufCal[i];
   end;

   glEnergBal[0] := glEnergBal[1] + glEnergBal[2] + glEnergBal[3];
   glEnergCal[0] := glEnergCal[1] + glEnergCal[2] + glEnergCal[3];
   
   for i := 0 to 3 do
   begin
     glEnergCal[i] := glEnergBal[i] - glEnergCal[i];
   end;
   Page.ShowBandByName('MasterData2');
end;

procedure TRPGomelBalans.FindMax(var Page: TfrPage);
var i     : integer;
    Index : integer;
begin
   Page.ShowBandByName('MasterHeader3');
   for i := 0 to 4 do
   begin
     MaxPB[i] := 0;
     MaxPC[i] := 0;
     MaxBInd[i] := 0;
     MaxCInd[i] := 0;
   end;
   for i := 0 to Length(SBufBal) - 1 do
   begin
     Index := GetColorFromTariffs(i mod 48, m_pTarBal_P);
     if SBufBal[i]*2 > MaxPB[Index] then
     begin
       MaxPB[Index] := SBufBal[i]*2;
       MaxBInd[Index] := i;

     end;
     if (SBufBal[i] - SBufCal[i])*2 > MaxPC[Index] then
     begin
       MaxPC[Index] := (SBufBal[i] - SBufCal[i])*2;
       MaxCInd[Index] := i;
     end;
   end;
   for i := 1 to 4 do
   begin
     if MaxPB[i] > MaxPB[0] then
     begin
       MaxPB[0] := MaxPB[i];
       MaxBInd[0] := MaxBInd[i]
     end;

     if MaxPC[i] > MaxPC[0] then
     begin
       MaxPC[0] := MaxPC[i];
       MaxCInd[0] := MaxCInd[i]
     end;
   end;
   Page.ShowBandByName('MasterData3');
end;

procedure TRPGomelBalans.frReport1ManualBuild(Page: TfrPage);
var i                     : integer;
    SrEnTID, _30MinPowTID : integer;
begin
   if (sExprBal = '[x]') or (sExprBal = '') then
   begin
     sExprBal := '';
     sExprBal := 'v' + sgBalansVM.Cells[0, 1] + '_P';
     for i := 2 to sgBalansVM.RowCount - 1 do
       sExprBal := sExprBal + ' + ' + 'v' + sgBalansVM.Cells[0, i] + '_P';
   end;
   if (sExprCal = '[x]') or (sExprCal = '') then
   begin
     sExprCal := '';
     sExprCal := 'v' + sgCalcVM.Cells[0, 1] + '_P';
     for i := 2 to sgCalcVM.RowCount - 1 do
       sExprCal := sExprCal + ' + ' + 'v' + sgCalcVM.Cells[0, i] + '_P';
   end;
   for i := 0 to 4 do
   begin
     glEnergBal[i] := 0;
     glEnergCal[i] := 0;
   end;
   Page.ShowBandByType(btReportTitle);
   SrEnTID      := FDB.LoadTID(QRY_SRES_ENR_EP);
   _30MinPowTID := FDB.LoadTID(QRY_E30MIN_POW_EP);
   FDB.GetTMTarPeriodsTableGr(BalansGrID, SrEnTID, m_pTarBal_E);
   FDB.GetTMTarPeriodsTableGr(CalcGrID, SrEnTID, m_pTarCal_E);
   FDB.GetTMTarPeriodsTableGr(BalansGrID, _30MinPowTID, m_pTarBal_P);
   FDB.GetTMTarPeriodsTableGr(CalcGrID, _30MinPowTID, m_pTarCal_P);
   ReadSlicesBal(Page);
   ReadSlicesCal(Page);
   FillTotalRasx(Page);
   FindMax(Page);
   Page.ShowBandByName('PageFooter1');
//   FindMaxBal(Page);
//   FindMaxCal(Page);
   {Page.ShowBandByName('MasterHeader1');
   Page.ShowBandByName('MasterData1');
   Page.ShowBandByName('MasterHeader2');
   Page.ShowBandByName('MasterData2');
   Page.ShowBandByName('MasterHeader3');
   Page.ShowBandByName('MasterData3');}
end;

function TRPGomelBalans.GetDateStrFrInd(ind: integer): String;
var nHal : integer;
begin
   nHal := ind mod 48;
   if nHal mod 2 = 0 then
     Result := IntToStr(nHal div 2) + ':' + IntToStr(nHal mod 2 * 30) + '0'
   else
     Result := IntToStr(nHal div 2) + ':' + IntToStr(nHal mod 2 * 30);
   Result := Result + ' ' +  DateToStr(dtBegin.DateTime + ind div 48);
end;

procedure TRPGomelBalans.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin
   if ParName = 'KindEnAll'   then ParValue := strKindEnAll;
   if ParName = 'WorksName'   then ParValue := WorksName;
   if ParName = 'NDogovor'    then ParValue := NDogovor;
   if ParName = 'DateB'       then ParValue := DateToStr(dtBegin.DateTime);
   if ParName = 'DateE'       then ParValue := DateToStr(dtEnd.DateTime);
   if ParName = 'TarifPlane'  then ParValue := '';
   if ParName = 'KindEn'      then ParValue := KindEn;
   if ParName = 'TarName1'    then ParValue := glTarNames[1];
   if ParName = 'TarName2'    then ParValue := glTarNames[2];
   if ParName = 'TarName3'    then ParValue := glTarNames[3];
   if ParName = 'NameCounter' then ParValue := globalMeterName;
   if ParName = 'KoefT1'      then ParValue := glKoef;
   if ParName = 'MeterN'      then ParValue := MeterN;
   if ParName = 'PokEnergE'   then ParValue := glPokEnergE;
   if ParName = 'PokEnergB'   then ParValue := glPokEnergB;
   if ParName = 'EnergT1S'    then ParValue := RVLPr(glEnergS[3], 5);
   if ParName = 'EnergT2S'    then ParValue := RVLPr(glEnergS[1], 5);
   if ParName = 'EnergT3S'    then ParValue := RVLPr(glEnergS[2], 5);
   if ParName = 'EnergTsS'    then ParValue := RVLPr(glEnergS[0], 5);
   if ParName = 'EnergT1'     then ParValue := RVLPr(glEnergRasx[3], 5);
   if ParName = 'EnergT2'     then ParValue := RVLPr(glEnergRasx[1], 5);
   if ParName = 'EnergT3'     then ParValue := RVLPr(glEnergRasx[2], 5);
   if ParName = 'EnergTs'     then ParValue := RVLPr(glEnergRasx[0], 5);
   if ParName = 'EnerT1SumB'  then ParValue := RVLPr(glEnergBal[3], 5);
   if ParName = 'EnerT2SumB'  then ParValue := RVLPr(glEnergBal[1], 5);
   if ParName = 'EnerT3SumB'  then ParValue := RVLPr(glEnergBal[2], 5);
   if ParName = 'EnerTsSumB'  then ParValue := RVLPr(glEnergBal[0], 5);
   if ParName = 'EnerT1SumR'  then ParValue := RVLPr(glEnergCal[3], 5);
   if ParName = 'EnerT2SumR'  then ParValue := RVLPr(glEnergCal[1], 5);
   if ParName = 'EnerT3SumR'  then ParValue := RVLPr(glEnergCal[2], 5);
   if ParName = 'EnerTsSumR'  then ParValue := RVLPr(glEnergCal[0], 5);
   if ParName = 'PTarName1'   then ParValue := FindTarName(1, m_pTarBal_P);
   if ParName = 'PTarName2'   then ParValue := FindTarName(2, m_pTarBal_P);
   if ParName = 'MaxP1B'      then ParValue := RVLPrStr(MaxPB[1], 5) + #10 + GetDateStrFrInd(MaxBInd[1]);
   if ParName = 'MaxP2B'      then ParValue := RVLPrStr(MaxPB[2], 5) + #10 + GetDateStrFrInd(MaxBInd[2]);
   if ParName = 'MaxPAB'      then ParValue := RVLPrStr(MaxPB[0], 5) + #10 + GetDateStrFrInd(MaxBInd[0]);
   if ParName = 'MaxP1R'      then ParValue := RVLPrStr(MaxPC[1], 5) + #10 + GetDateStrFrInd(MaxCInd[1]);
   if ParName = 'MaxP2R'      then ParValue := RVLPrStr(MaxPC[2], 5) + #10 + GetDateStrFrInd(MaxCInd[2]);
   if ParName = 'MaxPAR'      then ParValue := RVLPrStr(MaxPC[0], 5) + #10 + GetDateStrFrInd(MaxCInd[0]);
   if ParName = 'FirstSign'   then ParValue := FirstSign;
   if ParName = 'SecondSign'  then ParValue := SecondSign;
   if ParName = 'ThirdSign'   then ParValue := ThirdSign;
end;

end.
