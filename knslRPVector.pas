{**
 * Project:     Konus-2000E
 * File:        knslRPVector.pas
 * Description: Модуль отчета "Векторная диаграмма"
 *
 * Delphi version 5
 *
 * Category    Reporting
 * Package     Reports
 * Subpackage: knslRPVector
 * Author      Petrushevitch Roman <ukrop.gs@gmail.com>
 * Author:     $Author: Ukrop $
 * Copyright   2008-2012 Automation-2000, LLC
 *
 * License     Private Licence
 * Version:    2.3.33.763 SVN: $Id: knslRPVector.pas 44 2012-05-22 14:11:19Z Ukrop $
 * Link        Reports/VectorDiagram
 *}

unit knslRPVector;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,Math,
  FR_Class, BaseGrid, AdvGrid, utltypes, utldatabase, utlTimeDate, utlconst,
  utlbox, utlexparcer, ExtCtrls, VectorDiagramHelper, ImgList;

type
  TRPVector = class(TForm)
    frReportVector: TfrReport;
    v_quad: TImageList;
    procedure frReportVectorGetValue(const ParName: String; var ParValue: Variant);
    procedure frReportVectorManualBuild(Page: TfrPage);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    m_Grid           : PTAdvStringGrid;
    m_Time           : PTComboBox;
    m_DB             : PCDBDynamicConn;
    m_VD             : TVectorDiagramHelper;
    m_Canvas         : TCanvas;
    m_AbonentID      : Integer;
    m_AbonentName    : String;
    m_AbonentAddress : String;
    m_ContractNumber : String;
    m_ObjectName  : string;

    m_ObjectNumber   : String;
    m_Precision      : Integer;
    m_WithKT         : Boolean;
    m_VMID           : WORD;
    m_Meter          : SL2TAG;

    m_VectorData      : SL3VectorData;
    m_GridSelectedRow : Integer;
    m_ReportDate      : TDateTime;
    m_ReportName : string;
    m_Messages   : TStringList;
    m_MessageID  : Integer;
    m_QuadrantNumber : Integer;
    m_Io : Double;

    function ValidateAndCalculate(var _V : SL3VectorData) : Boolean;
    function CalcIo(_V : SL3VectorData) : Double;
    function GetQuadrantAngle(_P,_Q,_Angle : Double) : Double;
  public
    procedure OnFormResize;
    procedure PrepareTable;
    procedure PrintPreview(Date : TDateTime; ItemIndMaxCtrl:Integer);
  public
    property Grid           : PTAdvStringGrid  read m_Grid            write m_Grid;
    property Time           : PTComboBox       read m_Time            write m_Time;
    property Precision      : Integer          read m_Precision       write m_Precision;
    property PDB            : PCDBDynamicConn  read m_DB              write m_DB;
    property AbonentID      : Integer          read m_AbonentID       write m_AbonentID;
    property AbonentName    : String           read m_AbonentName     write m_AbonentName;
    property AbonentAddress : String           read m_AbonentAddress  write m_AbonentAddress;
    property ObjectNumber   : String           read m_ObjectNumber    write m_ObjectNumber;
    property WithKT         : Boolean          read m_WithKT          write m_WithKT;
    property ContractNumber : String           read m_ContractNumber  write m_ContractNumber;
    property ObjectName     : String           read m_ObjectName      write m_ObjectName;
  end;

var
  RPVector : TRPVector;

const
  DataColor         : Array[0..5] Of TColor    = (clOlive, clOlive, clGreen, clGreen, clRed, clRed);
  DataLine          : Array[0..5] Of Cardinal = (PS_SOLID, PS_SOLID, PS_DASH, PS_DASH, PS_DOT, PS_DOT);
  c_Precisions      : Array[0..5] Of String = (
        '',
        'второй и последующие ',
        'третий и последующие ',
        'четвертый и последующие ',
        'пятый и последующие ',
        'шестой и последующие '
  );
  c_PQIUF             : Int64 = 4054464;
  c_IUFC              : Int64 = 31309824;
//  c_IUFC              : Int64 = 33406976;

implementation

{$R *.DFM}

procedure TRPVector.PrepareTable();
var
  Meters : SL2TAGREPORTLIST;
  i      : integer;
  l_HH, l_MM, l_SS, l_MSS : WORD;
begin
  if m_Grid=Nil then exit;
  if (m_Time = nil) then exit;
  m_Grid.ColCount      := 5;
  m_Grid.RowCount      := 60;
  m_Grid.Cells[0,0]    := '№ п.п';
  m_Grid.Cells[1,0]    := 'Наименование учета';
  m_Grid.Cells[2,0]    := 'Номер счетчика';
  m_Grid.Cells[3,0]    := 'Коэффициент';
  m_Grid.Cells[4,0]    := 'Тип счетчика';
  m_Grid.ColWidths[0]  := 30;
  m_Grid.FixedCols := 1;
  m_Grid.FixedRows := 1;

  m_Time.Clear();
  for i:=0 to 48 do
    m_Time.Items.Add(Format('%0.2d:%0.2d', [i div 2, (i mod 2)*30]));
  DecodeTime(Now(), l_HH, l_MM, l_SS, l_MSS);
  m_Time.ItemIndex := l_HH*2 + l_MM div 30;

  if not m_DB.GetMeterGLVTableForReport(m_AbonentID,-1,0, Meters) then
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


procedure TRPVector.OnFormResize;
Var
    i : Integer;
Begin
    if m_Grid=Nil then exit;
    for i:=1 to m_Grid.ColCount-1  do m_Grid.ColWidths[i]  := trunc((m_Grid.Width-2*m_Grid.ColWidths[0])/(m_Grid.ColCount-1));
    //PChild.OnFormResize;
End;

procedure TRPVector.PrintPreview(Date : TDateTime; ItemIndMaxCtrl:Integer);
var
  a, b, c,l_AngleA,l_AngleB,l_AngleC : Double;
  i : Integer;
  l_Mult : TPoint;
  l_Pic  : TBitmap;
begin
  m_Messages.Clear();
  if ItemIndMaxCtrl = 0 then
    m_GridSelectedRow   := 1
  else
    m_GridSelectedRow   := ItemIndMaxCtrl;

  m_VMID := StrToIntDef(m_Grid.cells[0,m_GridSelectedRow],0);
  for i := 0 to 5 do
  begin
     m_VD.m_Vectors[i].Pen.Color := DataColor[i];
     m_VD.m_Vectors[i].Pen.Width := 3
  end;
  Date := trunc(Date);
  Date := Date + EncodeTime(m_Time.ItemIndex div 2, (m_Time.ItemIndex mod 2) * 30, 0, 0);
  m_ReportDate  := Date;

  m_QuadrantNumber := 1;
  if (true = m_DB.GetOneVector(Date, m_VMID, m_VectorData)) then
  begin
    if (not m_WithKT and m_DB.GetMMeterTable(m_VMID, m_Meter)) then
    begin
      m_Meter.m_sfKI := m_Meter.m_sfKI;
      m_Meter.m_sfKU := m_Meter.m_sfKU;
    end else
    begin
      m_Meter.m_sfKI := 1;
      m_Meter.m_sfKU := 1;
    end;
{
      PA[i] := RVL((UA[i]*IA[i]*cos(l_AngleA))/1000);
      PB[i] := RVL((UB[i]*IB[i]*cos(l_AngleB))/1000);
      PC[i] := RVL((UC[i]*IC[i]*cos(l_AngleC))/1000);
      PS[i] := (PA[i] + PB[i] + PC[i]);

      QA[i] := RVL((UA[i]*IA[i]*sin(l_AngleA))/1000);
      QB[i] := RVL((UB[i]*IB[i]*sin(l_AngleB))/1000);
      QC[i] := RVL((UC[i]*IC[i]*sin(l_AngleC))/1000);
      QS[i] := (QA[i] + QB[i] + QC[i]);

      SA[i] := RVL(sqrt(PA[i]*PA[i] + QA[i]*QA[i]));
      SB[i] := RVL(sqrt(PB[i]*PB[i] + QB[i]*QB[i]));
      SC[i] := RVL(sqrt(PC[i]*PC[i] + QC[i]*QC[i]));
      SS[i] := (SA[i] + SB[i] + SC[i]);

}

    with m_VectorData do
    begin
      if (PA=0)and(PB=0)and(PC=0)and
         (QA=0)and(QB=0)and(QC=0)then
      Begin
       l_AngleA := ArcCos(COSFA)* 180 / PI;
       l_AngleB := ArcCos(COSFB)* 180 / PI;
       l_AngleC := ArcCos(COSFC)* 180 / PI;

       if (l_AngleA > 90) then l_AngleA := l_AngleA - 90;
       if (l_AngleB > 90) then l_AngleB := l_AngleB - 90;
       if (l_AngleC > 90) then l_AngleC := l_AngleC - 90;

       l_AngleA := l_AngleA * PI / 180;
       l_AngleB := l_AngleB * PI / 180;
       l_AngleC := l_AngleC * PI / 180;

       PA := RVL((UA*IA*cos(l_AngleA))/1000);
       PB := RVL((UB*IB*cos(l_AngleB))/1000);
       PC := RVL((UC*IC*cos(l_AngleC))/1000);
       PS := (PA + PB + PC);

       QA := RVL((UA*IA*sin(l_AngleA))/1000);
       QB := RVL((UB*IB*sin(l_AngleB))/1000);
       QC := RVL((UC*IC*sin(l_AngleC))/1000);
       QS := (QA + QB + QC);

       SA := RVL(sqrt(PA*PA + QA*QA));
       SB := RVL(sqrt(PB*PB + QB*QB));
       SC := RVL(sqrt(PC*PC + QC*QC));
       SS := (SA + SB + SC);
      End;

      FREQ  := RVL(FREQ);
      IA    := RVL(IA / m_Meter.m_sfKI);
      UA    := RVL(UA / m_Meter.m_sfKU);
      COSFA := RVL(COSFA);
      PA    := RVL(PA / m_Meter.m_sfKI / m_Meter.m_sfKU);
      QA    := RVL(QA / m_Meter.m_sfKI / m_Meter.m_sfKU);
      SA    := RVL(SA / m_Meter.m_sfKI / m_Meter.m_sfKU);

      IB    := RVL(IB / m_Meter.m_sfKI);
      UB    := RVL(UB / m_Meter.m_sfKU);
      COSFB := RVL(COSFB);
      PB    := RVL(PB / m_Meter.m_sfKI / m_Meter.m_sfKU);
      QB    := RVL(QB / m_Meter.m_sfKI / m_Meter.m_sfKU);
      SB    := RVL(SB / m_Meter.m_sfKI / m_Meter.m_sfKU);

      IC    := RVL(IC / m_Meter.m_sfKI);
      UC    := RVL(UC / m_Meter.m_sfKU);
      COSFC := RVL(COSFC);
      PC    := RVL(PC / m_Meter.m_sfKI / m_Meter.m_sfKU);
      QC    := RVL(QC / m_Meter.m_sfKI / m_Meter.m_sfKU);
      SC    := RVL(SC / m_Meter.m_sfKI / m_Meter.m_sfKU);

      PS    := RVL(PS / m_Meter.m_sfKI / m_Meter.m_sfKU);
      QS    := RVL(QS / m_Meter.m_sfKI / m_Meter.m_sfKU);
      SS    := RVL(SS / m_Meter.m_sfKI / m_Meter.m_sfKU);
      COSFS := RVL(COSFS);
    end;
    
    ValidateAndCalculate(m_VectorData);
  end else
    m_Messages.Add('Данные отсутствуют.');

  try
    l_Pic := TfrPictureView(frReportVector.FindObject('iQuadrant')).Picture.Bitmap;
    l_Pic.Width := 22;
    l_Pic.Height := 22;
    v_quad.GetBitmap(m_QuadrantNumber-1, l_Pic);
  except
  end;

  m_VD.m_Vectors[0].Name := 'I';
  m_VD.m_Vectors[0].SubName := 'a';
  m_VD.m_Vectors[0].Linked := 1;
  m_VD.m_Vectors[0].NormalizeGroup := 1;
  m_VD.m_Vectors[1].Name := 'U';
  m_VD.m_Vectors[1].SubName := 'a';
  m_VD.m_Vectors[1].NormalizeGroup := 0;

  m_VD.m_Vectors[2].Name := 'I';
  m_VD.m_Vectors[2].SubName := 'b';
  m_VD.m_Vectors[2].Linked := 3;
  m_VD.m_Vectors[2].NormalizeGroup := 1;
  m_VD.m_Vectors[3].Name := 'U';
  m_VD.m_Vectors[3].SubName := 'b';
  m_VD.m_Vectors[3].NormalizeGroup := 0;

  m_VD.m_Vectors[4].Name := 'I';
  m_VD.m_Vectors[4].SubName := 'c';
  m_VD.m_Vectors[4].Linked := 5;
  m_VD.m_Vectors[4].NormalizeGroup := 1;
  m_VD.m_Vectors[5].Name := 'U';
  m_VD.m_Vectors[5].SubName := 'c';
  m_VD.m_Vectors[5].NormalizeGroup := 0;

  m_VD.m_Vectors[0].Value := m_VectorData.IA;
  m_VD.m_Vectors[1].Value := m_VectorData.UA;
  m_VD.m_Vectors[2].Value := m_VectorData.IB;
  m_VD.m_Vectors[3].Value := m_VectorData.UB;
  m_VD.m_Vectors[4].Value := m_VectorData.IC;
  m_VD.m_Vectors[5].Value := m_VectorData.UC;

  a := GetQuadrantAngle(m_VectorData.PA, m_VectorData.QA, ArcCos(m_VectorData.COSFA)* 180 / PI);
  b := GetQuadrantAngle(m_VectorData.PB, m_VectorData.QB, ArcCos(m_VectorData.COSFB)* 180 / PI);
  c := GetQuadrantAngle(m_VectorData.PC, m_VectorData.QC, ArcCos(m_VectorData.COSFC)* 180 / PI);

  //if (a > 90) then a := a - 90;
  //if (b > 90) then b := b - 90;
  //if (c > 90) then c := c - 90;
  
  m_VD.m_Vectors[0].Angle := a / 180 * PI;
  m_VD.m_Vectors[1].Angle := 0;
  m_VD.m_Vectors[2].Angle := (120 + b) / 180 * PI;
  m_VD.m_Vectors[3].Angle := (120 / 180) * PI;
  m_VD.m_Vectors[4].Angle := (240 + c) / 180 * PI;
  m_VD.m_Vectors[5].Angle := (240 / 180) * PI;

  m_VD.UseBitmap(m_Canvas);
  m_VD.Paint();

  frReportVector.ShowReport();
end;



procedure TRPVector.frReportVectorGetValue(const ParName: String; var ParValue: Variant);
begin
  if      ParName = 'Contract'       then ParValue := m_ContractNumber
  else if ParName = 'AbonentName'    then ParValue := m_AbonentName
  else if ParName = 'AbonentAddress' then ParValue := m_AbonentAddress
  else if ParName = 'ObjectID'       then ParValue := m_ObjectNumber
  else if ParName = 'ObjectName'     then ParValue := m_ObjectName

  else if ParName = 'MeterName'      then ParValue := m_Grid.Cells[1, m_GridSelectedRow]
  else if ParName = 'MeterFabNumber' then ParValue := m_Grid.Cells[2, m_GridSelectedRow]
  else if ParName = 'ReportName'     then ParValue := m_ReportName
  else if ParName = 'Message'        then ParValue := IntToStr(m_MessageID+2) +'. '+m_Messages[m_MessageID]
  else if ParName = 'QuadrantNumber' then ParValue := m_QuadrantNumber
  else if ParName = 'Io' then ParValue := FloatToStrF(m_Io, ffFixed, 18, m_Precision)  
  else if ParName = 'FREQ' then ParValue := FloatToStrF(m_VectorData.FREQ, ffFixed, 18, m_Precision)
  // Напряжение
  else if ParName = 'UA'   then ParValue := FloatToStrF(m_VectorData.UA, ffFixed, 18, m_Precision)
  else if ParName = 'UB'   then ParValue := FloatToStrF(m_VectorData.UB, ffFixed, 18, m_Precision)
  else if ParName = 'UC'   then ParValue := FloatToStrF(m_VectorData.UC, ffFixed, 18, m_Precision)

  // Ток
  else if ParName = 'IA'   then ParValue := FloatToStrF(m_VectorData.IA, ffFixed, 18, m_Precision)
  else if ParName = 'IB'   then ParValue := FloatToStrF(m_VectorData.IB, ffFixed, 18, m_Precision)
  else if ParName = 'IC'   then ParValue := FloatToStrF(m_VectorData.IC, ffFixed, 18, m_Precision)

  // Cos(ф)
  else if ParName = 'COSA' then ParValue := FloatToStrF(m_VectorData.COSFA, ffFixed, 18, m_Precision)
  else if ParName = 'COSB' then ParValue := FloatToStrF(m_VectorData.COSFB, ffFixed, 18, m_Precision)
  else if ParName = 'COSC' then ParValue := FloatToStrF(m_VectorData.COSFC, ffFixed, 18, m_Precision)
  else if ParName = 'COSS' then ParValue := FloatToStrF(m_VectorData.COSFS, ffFixed, 18, m_Precision)

  // ф
  else if ParName = 'FA' then ParValue := FloatToStrF(ArcCos(m_VectorData.COSFA)*180/PI, ffFixed, 18, m_Precision)
  else if ParName = 'FB' then ParValue := FloatToStrF(ArcCos(m_VectorData.COSFB)*180/PI, ffFixed, 18, m_Precision)
  else if ParName = 'FC' then ParValue := FloatToStrF(ArcCos(m_VectorData.COSFC)*180/PI, ffFixed, 18, m_Precision)

  // Активная мощность
  else if ParName = 'PA'   then ParValue := FloatToStrF(m_VectorData.PA, ffFixed, 18, m_Precision)
  else if ParName = 'PB'   then ParValue := FloatToStrF(m_VectorData.PB, ffFixed, 18, m_Precision)
  else if ParName = 'PC'   then ParValue := FloatToStrF(m_VectorData.PC, ffFixed, 18, m_Precision)
  else if ParName = 'PS'   then ParValue := FloatToStrF(m_VectorData.PS, ffFixed, 18, m_Precision)

  // Реактивная мощность
  else if ParName = 'QA'   then ParValue := FloatToStrF(m_VectorData.QA, ffFixed, 18, m_Precision)
  else if ParName = 'QB'   then ParValue := FloatToStrF(m_VectorData.QB, ffFixed, 18, m_Precision)
  else if ParName = 'QC'   then ParValue := FloatToStrF(m_VectorData.QC, ffFixed, 18, m_Precision)
  else if ParName = 'QS'   then ParValue := FloatToStrF(m_VectorData.QS, ffFixed, 18, m_Precision)

  // Полная мощность
  else if ParName = 'SA'   then ParValue := FloatToStrF(m_VectorData.SA, ffFixed, 18, m_Precision)
  else if ParName = 'SB'   then ParValue := FloatToStrF(m_VectorData.SB, ffFixed, 18, m_Precision)
  else if ParName = 'SC'   then ParValue := FloatToStrF(m_VectorData.SC, ffFixed, 18, m_Precision)
  else if ParName = 'SS'   then ParValue := FloatToStrF(m_VectorData.SS, ffFixed, 18, m_Precision);
end;



procedure TRPVector.frReportVectorManualBuild(Page: TfrPage);
var
  Year, Month, Day : word;
  i : Integer;
begin
  DecodeDate(m_ReportDate, Year, Month, Day);
  m_ContractNumber := trim(m_ContractNumber);
  if (m_ContractNumber <> '') then
    m_ContractNumber := m_ContractNumber;

  m_ReportName := 'Векторная диаграмма на ' + FormatDateTime('h:nn',m_ReportDate) + '  ' +IntToStr(Day) + ' ' + cDateTimeR.GetNameMonth1(Month)+ ' ' + IntToStr(Year) + ' года';
  Page.ShowBandByType({'PageHeader1'}btReportTitle);

  Page.ShowBandByName('MasterData1');

  if (m_Messages.Count > 0) then
  begin
    Page.ShowBandByName('MessageHeader1');
    for i:=0 to m_Messages.Count-1 do
    begin
      m_MessageID:= i;
      Page.ShowBandByName('MessageData1');
    end;
  end;
  Page.ShowBandByName('PageFooter1');
end;

procedure TRPVector.FormCreate(Sender: TObject);
var
  pic  : TPicture;
  bitm : TBitmap;
begin
  m_Messages := TStringList.Create();
  m_VD := TVectorDiagramHelper.Create();
  
  pic := TfrPictureView(frReportVector.FindObject('iVectorDiagram')).Picture;
  bitm := TBitmap.Create;
  bitm.Width  := 800;
  bitm.Height := 800;
  bitm.PixelFormat := pf32bit;
  pic.Graphic := bitm;
  m_Canvas := pic.Bitmap.Canvas;

  m_VD.SideLenght := 800;
  m_VD.VectorsCount := 6;
  m_VD.FixPhase := 0;
  m_VD.Circles := 1;
  m_VD.Font.Size := 24;
  m_VD.Grid.Width := 2;
  m_VD.Grid.Style := psDash;
  m_VD.DrawUIAngles := true;
  m_VD.Normalize := false;
  m_VD.DrawDecartCross := true;
  m_VD.DrawCirclesRadius:= false;
  m_VD.Draw30Angles :=true;
  m_VD.Normalize := true;
  m_VD.LegendMode := (lmLinked);
  m_VD.UseBitmap(m_Canvas);     

  ZeroMemory(@m_VectorData, sizeof(m_VectorData));
end;

function TRPVector.ValidateAndCalculate(var _V : SL3VectorData) : Boolean;
var
  l_AngleA, l_AngleB, l_AngleC : Double;
  l_Mes : String;
begin
  Result := false;
  m_Io := 0;
  m_QuadrantNumber := 1;
  with _V do
  if ((_V.DataMask AND c_IUFC)=c_IUFC) then // пришли данные I, U, FREQ, COS(ф)
  begin
    m_Messages.Add('Параметры I, U, cosФ, f являются условно одновременными.');
    m_Messages.Add('Параметры Ф, P, Q, S, Pсум, Qсум, Sсум, cosФ являются расчетными.');
    m_Messages.Add('В значениях параметров отброшены ' + c_Precisions[m_Precision] + 'знаки после запятой.');
    m_Messages.Add('Векторная диаграмма отображена исходя из предположения, что тип нагрузки индуктивный');
    m_QuadrantNumber := 1;
    Result := true;
    l_AngleA := ArcCos(COSFA)* 180 / PI;
    l_AngleB := ArcCos(COSFB)* 180 / PI;
    l_AngleC := ArcCos(COSFC)* 180 / PI;

    if (l_AngleA > 90) then l_AngleA := l_AngleA - 90;
    if (l_AngleB > 90) then l_AngleB := l_AngleB - 90;
    if (l_AngleC > 90) then l_AngleC := l_AngleC - 90;

    l_AngleA := l_AngleA * PI / 180;
    l_AngleB := l_AngleB * PI / 180;
    l_AngleC := l_AngleC * PI / 180;

    PA := RVL((UA*IA*cos(l_AngleA))/1000);
    PB := RVL((UB*IB*cos(l_AngleB))/1000);
    PC := RVL((UC*IC*cos(l_AngleC))/1000);
    PS := (PA + PB + PC);

    QA := RVL((UA*IA*sin(l_AngleA))/1000);
    QB := RVL((UB*IB*sin(l_AngleB))/1000);
    QC := RVL((UC*IC*sin(l_AngleC))/1000);
    QS := (QA + QB + QC);

    SA := RVL(sqrt(PA*PA + QA*QA));
    SB := RVL(sqrt(PB*PB + QB*QB));
    SC := RVL(sqrt(PC*PC + QC*QC));
    SS := (SA + SB + SC);

    if SS <> 0 then
      COSFS := RVL(PS/SS)
    else
      COSFS := 0;
    m_Io := CalcIo(_V);
    
  end
  else if ((_V.DataMask AND c_PQIUF)=c_PQIUF) then // пришли данные P, Q, I, U, FREQ
  begin
    m_Messages.Add('Параметры I, U, P, Q, f являются условно-одновременными.');
    m_Messages.Add('Параметры S, cosФ, Ф, Pсум, Qсум, Sсум являются расчетными.');
    m_Messages.Add('В значениях параметров отброшены ' + c_Precisions[m_Precision] + 'знаки после запятой.');
    Result := true;

    // рассчитаем полные мощности на фазах
    SA := RVL(sqrt(PA*PA + QA*QA));
    SB := RVL(sqrt(PB*PB + QB*QB));
    SC := RVL(sqrt(PC*PC + QC*QC));

    PS := (PA + PB + PC);
    QS := (QA + QB + QC);
    SS := (SA + SB + SC);

    // рассчитаем коэффициенты мощности на фазах
    if (SA <> 0) then COSFA := RVL(PA / SA);
    if (SB <> 0) then COSFB := RVL(PB / SB);
    if (SC <> 0) then COSFC := RVL(PC / SC);
    if (SS <> 0) then COSFS := RVL(PS / SS);

    if (UA <> 0) then IA := RVL(SA / UA * 1000);
    if (UB <> 0) then IB := RVL(SB / UB * 1000);
    if (UC <> 0) then IC := RVL(SC / UC * 1000);

    if (PS >= 0) and (QS >= 0) then
      m_QuadrantNumber := 1
    else if (PS < 0) and (QS >= 0) then
      m_QuadrantNumber := 2
    else if (PS < 0) and (QS < 0) then
      m_QuadrantNumber := 3
    else
      m_QuadrantNumber := 4;
    m_Io := CalcIo(_V);
  end else if (_V.DataMask = 0) then
    m_Messages.Add('Данные отсутствуют')
  else
    m_Messages.Add('Данные не достоверны.');
  Result := true;
end;


procedure TRPVector.FormDestroy(Sender: TObject);
begin
  m_Messages.Destroy();
end;

function TRPVector.GetQuadrantAngle(_P,_Q,_Angle : Double) : Double;
begin
  Result := _Angle;
  {
  if (_P > 0) and (_Q > 0) then
    Result := _Angle
  else
  }
  if (_P > 0) and(_Q < 0) then
    Result := -_Angle
  else if (_P < 0) and(_Q > 0) then
    Result := 180-_Angle
  else if (_P < 0) and(_Q < 0) then
    Result := -180+_Angle;
end;

function TRPVector.CalcIo(_V : SL3VectorData) : Double;
var
  a,b,c : Double;
  im, re : Double;
begin
  Result := 0;
  a := ArcCos(_V.COSFA);
  b := ArcCos(_V.COSFB) + 120/180*pi;
  c := ArcCos(_V.COSFC) + 240/180*pi;

  re := _v.IA*cos(a) + _v.IB*cos(b) + _v.Ic*cos(c);
  im := _v.IA*sin(a) + _v.IB*sin(b) + _v.Ic*sin(c);
  Result := sqrt(re*re+im*im);
end;

end.
