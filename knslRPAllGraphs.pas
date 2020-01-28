{**
 * Project:     Konus-2000E
 * File:        knslRPAllGraphs.pas
 * Description: Модуль отчета "Энергия за сутки"
 *
 * Delphi version 5
 *
 * Category    Reports
 * Package     RP
 * Author      Petrushevitch Roman <ukrop.gs@gmail.com>
 * Author      $Author$
 * Copyright   2008-2012 Automation-2000, LLC
 *
 * License     Private Licence
 * Version:    2.3.33.770 SVN: $Id$
 * Link        Reports/AllGraphs
 *}

unit knslRPAllGraphs;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FR_Class,
  utldatabase, utltypes, utlbox, utlconst;

type
  TRepRow = packed record
    m_HHID    : Integer;
    m_Time    : String[5];
    m_DispAP  : Double;
    m_DeltaAP : Double;
    m_DispAM  : Double;
    m_DeltaAM : Double;
    m_DispRP  : Double;
    m_DeltaRP : Double;
    m_DispRM  : Double;
    m_DeltaRM : Double;
  end;

  TRepTable = packed record
    m_MeterName    : String;
    m_Ki    : Double;
    m_Ku    : Double;
    m_HHS   : array[0..47] of TRepRow;
    m_Max   : array[0..3] of Double;
    m_Sum   : array[0..3] of Double;
  end;
  
  TRPAllGraphs = class(TForm)
    m_Report: TfrReport;
    procedure m_ReportGetValue(const _ParName: String; var _ParValue: Variant);
    procedure m_ReportManualBuild(_Page: TfrPage);
    procedure FormCreate(Sender: TObject);
  private
    m_DB          : PCDBDynamicConn;
    m_Grid        : PTAdvStringGrid;
    m_Precision   : Integer;
    m_WithKT      : Boolean;
    m_CurrentHHID : Integer;
    m_Meters      : SL2TAGREPORTLIST;
    m_ReportData  : TRepTable;

    m_VMID           : Integer;
    m_AbonentID      : Integer;
    m_ReportDate     : TDateTime;

    PH_ReportName     : String;
    PH_AbonentName    : String;
    PH_AbonentAddress : String;
    PH_ContractNumber : String;
    PH_Contract       : String;
    PH_ObjectNumber   : String;
    PH_ObjectName     : String;

    PH_CurrentMeterName   : String;
    PH_CurrentMeterNumber : String;
    PH_CurrentMeterType   : String;
    PH_SlicesValidity     : Integer;
    PH_SlicesRatio        : Integer;
    PH_CurrentMeterKI,
    PH_CurrentMeterKU,
    PH_CurrentMeterKE     : Extended;

    function  ReadData(_Date : TDateTime) : Boolean;
    function  GetMeterTypeAlias(_Name : String):String;
  public
    procedure PrepareTable();
    procedure InitMeters();
    procedure ShowPreview(_Date : TDateTime);
  public
    property Grid   : PTAdvStringGrid read m_Grid            write m_Grid;
    property DB     : PCDBDynamicConn read m_DB              write m_DB;
    property Precision      : Integer read m_Precision       write m_Precision;
    property WithKT         : Boolean read m_WithKT          write m_WithKT;    
    property AbonenID       : Integer read m_AbonentID       write m_AbonentID;
    property AbonentName    : String  read PH_AbonentName    write PH_AbonentName;
    property AbonentAddress : String  read PH_AbonentAddress write PH_AbonentAddress;
    property Contract       : String  read PH_ContractNumber write PH_ContractNumber;
    property ObjectName     : String  read PH_ObjectName     write PH_ObjectName;
    property ObjectNumber   : String  read PH_ObjectNumber   write PH_ObjectNumber;
  end;

var
  f_RPAllGraphs: TRPAllGraphs;

implementation

{$R *.DFM}

procedure TRPAllGraphs.m_ReportGetValue(const _ParName: String; var _ParValue: Variant);
begin
   if      _ParName = 'Contract' then _ParValue := PH_Contract
   else if _ParName = 'AbonentName'    then _ParValue := PH_AbonentName
   else if _ParName = 'AbonentAddress' then _ParValue := PH_AbonentAddress
   else if _ParName = 'ObjectNumber'     then _ParValue := PH_ObjectNumber
   else if _ParName = 'ObjectName'       then _ParValue := PH_ObjectName
   else if _ParName = 'ReportName'       then _ParValue := PH_ReportName
   else if _ParName = 'ReportDate'       then _ParValue := FormatDateTime('dd.mm.yyyy', m_ReportDate)

   else if _ParName = 'CurrentMeterName'   then _ParValue := PH_CurrentMeterName
   else if _ParName = 'CurrentMeterNumber' then _ParValue := PH_CurrentMeterNumber
   else if _ParName = 'CurrentMeterState' then _ParValue := FloatToStrF(PH_SlicesRatio/192*100, ffFixed, 18, 0) + '%'
   else if _ParName = 'CurrentMeterValidity' then _ParValue := FloatToStrF(PH_SlicesValidity/192*100, ffFixed, 18, 0) + '%'
   else if _ParName = 'CurrentMeterType' then _ParValue := GetMeterTypeAlias(PH_CurrentMeterType)
   else if _ParName = 'CurrentMeterKi' then _ParValue := FloatToStrF(PH_CurrentMeterKI, ffFixed, 18, 0)
   else if _ParName = 'CurrentMeterKu' then _ParValue := FloatToStrF(PH_CurrentMeterKU, ffFixed, 18, 0)
   else if _ParName = 'CurrentMeterKT' then _ParValue := FloatToStrF(PH_CurrentMeterKI, ffFixed, 18, 0)
                                                         +'·'+FloatToStrF(PH_CurrentMeterKU, ffFixed, 18, 0)
                                                         +'='+FloatToStrF(PH_CurrentMeterKE, ffFixed, 18, 0)

   else if _ParName = 'HHID' then _ParValue := (m_CurrentHHID+1)
   else if _ParName = 'HHTime' then _ParValue := Format('%0.2d:%0.2d', [(m_CurrentHHID) div 2, ((m_CurrentHHID) mod 2)*30])

   // значения                                      //RVLPr(Data.Items[i].m_sfValue/PH_CurrentMeterKE, MeterPrecision[m_VMID]);
   else if _ParName = 'DisplayAp' then _ParValue := FloatToStrF(RVL(m_ReportData.m_HHS[m_CurrentHHID].m_DispAP / PH_CurrentMeterKE), ffFixed, 18, m_Precision)
   else if _ParName = 'DisplayAm' then _ParValue := FloatToStrF(RVL(m_ReportData.m_HHS[m_CurrentHHID].m_DispAM / PH_CurrentMeterKE), ffFixed, 18, m_Precision)
   else if _ParName = 'DisplayRp' then _ParValue := FloatToStrF(RVL(m_ReportData.m_HHS[m_CurrentHHID].m_DispRP / PH_CurrentMeterKE), ffFixed, 18, m_Precision)
   else if _ParName = 'DisplayRm' then _ParValue := FloatToStrF(RVL(m_ReportData.m_HHS[m_CurrentHHID].m_DispRM / PH_CurrentMeterKE), ffFixed, 18, m_Precision)

   else if _ParName = 'DeltaAp' then _ParValue := FloatToStrF(RVL(m_ReportData.m_HHS[m_CurrentHHID].m_DeltaAP), ffFixed, 18, m_Precision)
   else if _ParName = 'DeltaAm' then _ParValue := FloatToStrF(RVL(m_ReportData.m_HHS[m_CurrentHHID].m_DeltaAM), ffFixed, 18, m_Precision)
   else if _ParName = 'DeltaRp' then _ParValue := FloatToStrF(RVL(m_ReportData.m_HHS[m_CurrentHHID].m_DeltaRP), ffFixed, 18, m_Precision)
   else if _ParName = 'DeltaRm' then _ParValue := FloatToStrF(RVL(m_ReportData.m_HHS[m_CurrentHHID].m_DeltaRM), ffFixed, 18, m_Precision)

   else if _ParName = 'MaxAp' then _ParValue := FloatToStrF(RVL(m_ReportData.m_Max[0]), ffFixed, 18, m_Precision)
   else if _ParName = 'MaxAm' then _ParValue := FloatToStrF(RVL(m_ReportData.m_Max[1]), ffFixed, 18, m_Precision)
   else if _ParName = 'MaxRp' then _ParValue := FloatToStrF(RVL(m_ReportData.m_Max[2]), ffFixed, 18, m_Precision)
   else if _ParName = 'MaxRm' then _ParValue := FloatToStrF(RVL(m_ReportData.m_Max[3]), ffFixed, 18, m_Precision)

   else if _ParName = 'SumAp' then _ParValue := FloatToStrF(RVL(m_ReportData.m_Sum[0]), ffFixed, 18, m_Precision)
   else if _ParName = 'SumAm' then _ParValue := FloatToStrF(RVL(m_ReportData.m_Sum[1]), ffFixed, 18, m_Precision)
   else if _ParName = 'SumRp' then _ParValue := FloatToStrF(RVL(m_ReportData.m_Sum[2]), ffFixed, 18, m_Precision)
   else if _ParName = 'SumRm' then _ParValue := FloatToStrF(RVL(m_ReportData.m_Sum[3]), ffFixed, 18, m_Precision)
{
   else
    _ParValue := '-'+_ParName + '-';
}
end;

procedure TRPAllGraphs.m_ReportManualBuild(_Page: TfrPage);
var
  i : Integer;
begin
  if (trim(PH_ContractNumber)<> '') then
    PH_Contract := (PH_ContractNumber);
  _Page.ShowBandByName('MasterHeader1');
  for i:=0 to 47 do
  begin
    m_CurrentHHID := i;
    _Page.ShowBandByName('MasterData1');
  end;

  _Page.ShowBandByName('MasterFooter1');
  _Page.ShowBandByName('PageFooter1');
end;


procedure TRPAllGraphs.PrepareTable();
var
    i      : integer;
begin
  if m_Grid = nil then
    exit;

  m_Grid.ColCount      := 5;
  m_Grid.RowCount      := 1;
  m_Grid.Cells[0,0]    := '№ п.п';
  m_Grid.Cells[1,0]    := 'Наименование учета';
  m_Grid.Cells[2,0]    := 'Номер счетчика';
  m_Grid.Cells[3,0]    := 'Коэффициент';
  m_Grid.Cells[4,0]    := 'Тип счетчика';
  m_Grid.ColWidths[0]  := 40;
  m_Grid.ColWidths[1]  := 300;
  m_Grid.ColWidths[2]  := 120;
  m_Grid.ColWidths[3]  := 100;
  m_Grid.ColWidths[4]  := 100;
  m_Grid.FixedCols     := 1;

  if (m_Meters.Count > 0) then
  begin
    m_Grid.RowCount := m_Meters.Count+1;
    m_Grid.FixedRows     := 1;
    for i:=0 to m_Meters.Count-1 do
    begin
      if m_Meters.m_sMeter[i].m_sbyType = MET_VZLJOT then
        continue;
      m_Grid.Cells[0,i+1] := IntToStr(m_Meters.m_sMeter[i].m_swVMID);
      m_Grid.Cells[1,i+1] := m_Meters.m_sMeter[i].m_sVMeterName;
      m_Grid.Cells[2,i+1] := m_Meters.m_sMeter[i].m_sddPHAddres;
      m_Grid.Cells[3,i+1] := DVLS(m_Meters.m_sMeter[i].m_sfKI*m_Meters.m_sMeter[i].m_sfKU);
      m_Grid.Cells[4,i+1] := m_Meters.m_sMeter[i].m_sName;
    end;
  end else
  begin
    m_Grid.FixedRows := 0;
    m_Grid.RowCount  := 1;
  end;
end;

procedure TRPAllGraphs.ShowPreview(_Date : TDateTime);
var
  l_GridItem : Integer;
  l_Me : SL2TAGREPORT;
begin
  l_GridItem := m_Grid.Row-1;
  if (l_GridItem < 0) then
    exit;
  l_Me := m_Meters.m_sMeter[l_GridItem];
  PH_CurrentMeterName   := l_Me.m_sVMeterName;
  PH_CurrentMeterNumber := l_Me.m_sddPHAddres;
  PH_CurrentMeterType   := l_Me.m_sName;
  PH_CurrentMeterKI     := l_Me.m_sfKI;
  PH_CurrentMeterKU     := l_Me.m_sfKU;
  PH_CurrentMeterKE     := l_Me.m_sfKI*l_Me.m_sfKU;

  if (m_WithKT) then
  begin
    
  end;

  m_VMID := StrToIntDef(m_Grid.Cells[0, m_Grid.Row], -1);
  if (m_VMID < 0) then
    exit;

  m_ReportDate := _Date;
  // подготовить данные
  ReadData(_Date);

  // показать отчет
  m_Report.ShowReport();
end;

function TRPAllGraphs.ReadData(_Date : TDateTime) : Boolean;
var
  l_Tbl : L3GRAPHDATAS;
  i : Integer;
  l_Mask : Int64;
begin
  Result := false;

  if (m_DB.Get4EnergyGraphs(_Date, m_VMID, l_Tbl)) then
  begin
    m_ReportData.m_Max[0] := 0;
    m_ReportData.m_Max[1] := 0;
    m_ReportData.m_Max[2] := 0;
    m_ReportData.m_Max[3] := 0;
    m_ReportData.m_Sum[0] := 0;
    m_ReportData.m_Sum[1] := 0;
    m_ReportData.m_Sum[2] := 0;
    m_ReportData.m_Sum[3] := 0;

    m_ReportData.m_HHS[0].m_DispAP := l_Tbl.Items[0].m_swSumm;
    m_ReportData.m_HHS[0].m_DispAM := l_Tbl.Items[1].m_swSumm;
    m_ReportData.m_HHS[0].m_DispRP := l_Tbl.Items[2].m_swSumm;
    m_ReportData.m_HHS[0].m_DispRM := l_Tbl.Items[3].m_swSumm;
    for i:=0 to 47 do
    begin
      l_Mask := (1 shl i);
      if (l_Tbl.Items[0].m_sMaskReRead and l_Mask) = l_Mask then
        Inc(PH_SlicesValidity);
      if (l_Tbl.Items[1].m_sMaskReRead and l_Mask) = l_Mask then
        Inc(PH_SlicesValidity);
      if (l_Tbl.Items[2].m_sMaskReRead and l_Mask) = l_Mask then
        Inc(PH_SlicesValidity);
      if (l_Tbl.Items[3].m_sMaskReRead and l_Mask) = l_Mask then
        Inc(PH_SlicesValidity);

      if (l_Tbl.Items[0].m_sMaskRead and l_Mask) = l_Mask then
        Inc(PH_SlicesRatio);
      if (l_Tbl.Items[1].m_sMaskRead and l_Mask) = l_Mask then
        Inc(PH_SlicesRatio);
      if (l_Tbl.Items[2].m_sMaskRead and l_Mask) = l_Mask then
        Inc(PH_SlicesRatio);
      if (l_Tbl.Items[3].m_sMaskRead and l_Mask) = l_Mask then
        Inc(PH_SlicesRatio);

      m_ReportData.m_Sum[0] := m_ReportData.m_Sum[0] + l_Tbl.Items[0].v[i];
      m_ReportData.m_Sum[1] := m_ReportData.m_Sum[1] + l_Tbl.Items[1].v[i];
      m_ReportData.m_Sum[2] := m_ReportData.m_Sum[2] + l_Tbl.Items[2].v[i];
      m_ReportData.m_Sum[3] := m_ReportData.m_Sum[3] + l_Tbl.Items[3].v[i];

      m_ReportData.m_HHS[i].m_DeltaAP := l_Tbl.Items[0].v[i];
      m_ReportData.m_HHS[i].m_DeltaAM := l_Tbl.Items[1].v[i];
      m_ReportData.m_HHS[i].m_DeltaRP := l_Tbl.Items[2].v[i];
      m_ReportData.m_HHS[i].m_DeltaRM := l_Tbl.Items[3].v[i];

      if (i < 47) then
      begin
        m_ReportData.m_HHS[i+1].m_DispAP := m_ReportData.m_HHS[i].m_DispAP + m_ReportData.m_HHS[i].m_DeltaAP;
        m_ReportData.m_HHS[i+1].m_DispAM := m_ReportData.m_HHS[i].m_DispAM + m_ReportData.m_HHS[i].m_DeltaAM;
        m_ReportData.m_HHS[i+1].m_DispRP := m_ReportData.m_HHS[i].m_DispRP + m_ReportData.m_HHS[i].m_DeltaRP;
        m_ReportData.m_HHS[i+1].m_DispRM := m_ReportData.m_HHS[i].m_DispRM + m_ReportData.m_HHS[i].m_DeltaRM;
      end;

      if (m_ReportData.m_Max[0] < l_Tbl.Items[0].v[i]) then
        m_ReportData.m_Max[0] := l_Tbl.Items[0].v[i];

      if (m_ReportData.m_Max[1] < l_Tbl.Items[1].v[i]) then
        m_ReportData.m_Max[1] := l_Tbl.Items[1].v[i];

      if (m_ReportData.m_Max[2] < l_Tbl.Items[2].v[i]) then
        m_ReportData.m_Max[2] := l_Tbl.Items[2].v[i];

      if (m_ReportData.m_Max[3] < l_Tbl.Items[3].v[i]) then
        m_ReportData.m_Max[3] := l_Tbl.Items[3].v[i];
    end;
  end;
end;

procedure TRPAllGraphs.InitMeters();
begin
  if (m_AbonentID > -1) then
    m_DB.GetMeterGLVTableForReport(m_AbonentID,-1, 0, m_Meters);
end;

procedure TRPAllGraphs.FormCreate(Sender: TObject);
begin
 m_AbonentID := -1;
end;


function TRPAllGraphs.GetMeterTypeAlias(_Name : String):String;
begin
  if (_Name = 'SS301F3') or (_Name = 'SS301F4') then
    Result := 'CC-301';
end;

end.
