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
 * Version:    2.3.33.763 SVN: $Id: knsl3vectorframe.pas 46 2012-06-03 15:23:23Z Ukrop $
 * Link        Reports/VectorDiagram
 *}
unit knsl3VectorFrame;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, BaseGrid, AdvGrid, StdCtrls, jpeg, ExtCtrls, ComCtrls, ToolWin,
  utltypes,utlconst,utldatabase, AdvCGrid, ImgList,utlbox, asgprev,knsl5config,
  knsl3recalcmodule,knslProgressLoad,AdvOfficePager, AdvToolBar, AdvPanel,
  AdvAppStyler, AdvToolBarStylers, asgprint,Printers, AdvGridCSVPager,
  VectorDiagram, Math, AdvGlowButton,  utltimedate, Menus, AdvMenus,
  AdvMenuStylers, VectorDiagramHelper;
type
  TVectorFrame = class(TForm)
    imgDataView: TImageList;
    Panel5: TAdvPanel;
    AdvPanelStyler1: TAdvPanelStyler;
    AdvToolBarOfficeStyler1: TAdvToolBarOfficeStyler;
    dtp_Date: TDateTimePicker;
    AdvPanel2: TAdvPanel;
    Label2: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    e_IA: TEdit;
    e_UA: TEdit;
    e_COSA: TEdit;
    Bevel1: TBevel;
    Label3: TLabel;
    Label5: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    e_IB: TEdit;
    e_UB: TEdit;
    e_COSB: TEdit;
    Bevel2: TBevel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    e_IC: TEdit;
    e_UC: TEdit;
    e_COSC: TEdit;
    Bevel3: TBevel;
    lb_SlicesGiven: TListBox;
    e_Freq: TEdit;
    lb_Freq: TLabel;
    AdvPanel1: TAdvPanel;
    AdvToolBar1: TAdvToolBar;
    VectorStyler: TAdvFormStyler;
    Label1: TLabel;
    e_PA: TEdit;
    Label15: TLabel;
    e_QA: TEdit;
    Label16: TLabel;
    e_PB: TEdit;
    Label17: TLabel;
    e_QB: TEdit;
    Label18: TLabel;
    e_PC: TEdit;
    Label19: TLabel;
    e_QC: TEdit;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Bevel4: TBevel;
    e_QS: TEdit;
    e_PS: TEdit;
    e_S: TEdit;
    Label24: TLabel;
    e_KM: TEdit;
    AdvGlowMenuButton1: TAdvGlowMenuButton;
    AdvPopupMenu1: TAdvPopupMenu;
    AdvMenuOfficeStyler1: TAdvMenuOfficeStyler;
    N1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N8: TMenuItem;
    ap_VectorCanvas: TAdvPanel;
    cb_Precision: TComboBox;
    procedure OnCloseData(Sender: TObject; var Action: TCloseAction);
    procedure OnCreate(Sender: TObject);
    procedure OnUpDateData(Sender: TObject);
    procedure OnReloadMetadata(Sender: TObject);
    procedure OnChangeKiKu(Sender: TObject);
    function  ReturnCRC(m_sfValue:array of double):integer;
    procedure ViewData();

    procedure lb_SlicesGivenClick(Sender: TObject);
    procedure dtp_DateChange(Sender: TObject);
    procedure OnFormResize(Sender: TObject);
    procedure cb_PrecisionChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ap_VectorCanvasPaint(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect);
  private
    m_VD       : TVectorDiagramHelper;
    m_VDInit   : Boolean;
//    m_sVector  : SL3Vector;  {массив данных за указанный получас}
    m_sVectors_48 : SL3Vectors_48;
    m_WithKT     : Boolean;
    m_Meter      : SL2TAG;
    m_Precision  : Integer;
    m_Messages   : TStringList;
      m_SID       : Byte;

      m_nP       : SL2TAG;
//    m_pData   : CCDatas;
    FABOID    : Integer;
    FPage     : TAdvOfficePager;
    FIndex    : Integer;
    FCmdIndex : Integer;
    FMID      : Integer;
    FVMID     : Integer;
    FPRID     : Integer;
    FTID      : Integer;
    FSVStatus : Integer;
    FCLStatus : Integer;
    FsgVGrid  : PTAdvStringGrid;
//    m_pMetaTbl: CGRMetaData;
//    m_byInState  : array[0..100] of Byte;
//    m_byOutState : array[0..100] of Byte;
//    m_RowSize    : Integer;
    function ValidateAndCalculate(var _V : SL3Vectors_48) : Boolean;
    function  GetQuadrantAngle(_P,_Q,_Angle : Double) : Double;
  public
    procedure OnReloadVMeter;
    procedure Init;
    procedure SetHigthGrid(_Higth:Integer);
    function FindRow(pGrid:PTAdvStringGrid;str:String):Integer;
  public
    { Public declarations }
    property PABOID   : Integer         read FABOID    write FABOID;
    property PMID     : Integer         read FMID      write FMID;
    property PVMID    : Integer         read FVMID     write FVMID;
    property PPRID    : Integer         read FPRID     write FPRID;
    property PTID     : Integer         read FTID      write FTID;
    property PsgVGrid : PTAdvStringGrid read FsgVGrid  write FsgVGrid;
    property PPage    : TAdvOfficePager    read FPage     write FPage;
    property PIndex   : Integer         read FIndex    write FIndex;
    property PSVStatus: Integer         read FSVStatus write FSVStatus;
    property PCLStatus: Integer         read FCLStatus write FCLStatus;
  end;

var
  //fVectorFrame: TVectorFrame;
  nCIndex  : Integer = 0;
  b_KiKu   : boolean = true;

const
  DataColor         : Array[0..5] Of TColor    = (clOlive, clOlive, clGreen, clGreen, clRed, clRed);
  c_Precisions      : Array[0..5] Of String = (
        '',
        'второй (и последующие) ',
        'третий (и последующие) ',
        'четвертый (и последующие) ',
        'пятый (и последующие) ',
        'шестой (и последующие) '
  );
  c_PQIUF             : Int64 = 4054464;
  c_IUFC              : Int64 = 31309824;

implementation

{$R *.DFM}

procedure TVectorFrame.OnCloseData(Sender: TObject;
  var Action: TCloseAction);
begin
     Action := caFree;
     m_nCF.m_nSetColor.PVectorStyler := nil;
end;

procedure TVectorFrame.OnCreate(Sender: TObject);
var
   i : Integer;
begin
  m_VDInit := false;
  cb_Precision.ItemIndex := 3;
  m_Precision := 3;
  m_Messages := TStringList.Create();
  m_VD := TVectorDiagramHelper.Create();


  m_VD.VectorsCount := 6;
  m_VD.FixPhase := 0;
  m_VD.Circles := 1;
  m_VD.Font.Size := 12;
  m_VD.Grid.Width := 1;
  m_VD.Grid.Style := psSolid;
  m_VD.DrawUIAngles := true;
  m_VD.Normalize := false;
  m_VD.DrawDecartCross := true;
  m_VD.DrawCirclesRadius:= false;
  m_VD.Draw30Angles :=true;
  m_VD.Normalize := true;
  m_VD.LegendMode := (lmLinked);
//  m_VD.UseBitmap(m_VectorSurface.Canvas);
  m_VDInit := true;
  ZeroMemory(@m_sVectors_48, sizeof(m_sVectors_48));

  dtp_Date.DateTime := trunc(Now());
  m_nP.m_sfKI := 1;
  m_nP.m_sfKU := 1;
  m_WithKT    := true;
  m_nCF.m_nSetColor.PVectorStyler := @VectorStyler;
  m_nCF.m_nSetColor.SetAllStyle(m_nCF.StyleForm.ItemIndex);

   for i := 0 to 5 do
   begin
      m_VD.m_Vectors[i].Pen.Style := psSolid;
      m_VD.m_Vectors[i].Pen.Color := DataColor[i];
      m_VD.m_Vectors[i].Pen.Width := 1;
   end;

   m_VD.m_Vectors[0].Name := 'Ia';
   m_VD.m_Vectors[1].Name := 'Ua';
   m_VD.m_Vectors[2].Name := 'Ib';
   m_VD.m_Vectors[3].Name := 'Ub';
   m_VD.m_Vectors[4].Name := 'Ic';
   m_VD.m_Vectors[5].Name := 'Uc';
end;

procedure TVectorFrame.Init;
//var
//   mCL :  SCOLORSETTTAG;
Begin
   m_nP.m_sbyPortID := PPRID;
   m_nP.m_swMID     := PMID;
   m_pDB.GetMeterTable(m_nP);
//   m_pDB.GetColorTable(mCL);
//   m_RowSize := mCL.m_swFontSize+26;
   FsgVGrid.Tag := PVMID;
End;

procedure TVectorFrame.SetHigthGrid(_Higth:Integer);
Var
    i : Integer;
Begin
    for i:=1 to FsgVGrid.RowCount-1 do
      FsgVGrid.RowHeights[i]:= _Higth;
End;

function TVectorFrame.FindRow(pGrid:PTAdvStringGrid;str:String):Integer;
Var
   i : Integer;
Begin
   for i:=1 to pGrid.RowCount-1 do if pGrid.Cells[0,i]=str then
    Begin
     if (i-pGrid.VisibleRowCount)>0  then pGrid.TopRow := i-pGrid.VisibleRowCount+1 else pGrid.TopRow := 1;
     Result := i;
     exit;
    End;
    Result := 1;
End;

function TVectorFrame.ReturnCRC(m_sfValue:array of double):integer;
begin
 result := CalcCRCDB(@m_sfValue,length(m_sfValue)*sizeof(double));
end;

procedure TVectorFrame.OnUpDateData(Sender: TObject);
begin
   dtp_Date.OnChange(Sender);
end;

procedure TVectorFrame.OnReloadMetadata(Sender: TObject);
Var
     pDS : CMessageData;
begin
     pDS.m_swData0 := FIndex;
     SendMsgData(BOX_L3,FIndex,DIR_L4TOL3,AL_UPDMETADATA_REQ,pDS);
end;

procedure TVectorFrame.OnReloadVMeter;
Var
     pDS : CMessageData;
begin
     pDS.m_swData0 := FIndex;
     pDS.m_swData1 := FCmdIndex;
     SendMsgData(BOX_L3,FIndex,DIR_L4TOL3,AL_RELOADVMET_REQ,pDS);
end;

procedure TVectorFrame.OnChangeKiKu(Sender: TObject);
begin
   if (not m_WithKT) then
     (Sender as TMenuItem).Caption := 'С учетом коэфициентов тансформации'
   else
     (Sender as TMenuItem).Caption := 'Без учета коэфициентов тансформации';
   m_WithKT := not m_WithKT;
   lb_SlicesGivenClick(Sender);
end;

procedure TVectorFrame.lb_SlicesGivenClick(Sender: TObject);
var
  i : Integer;
  sq : Double;
  a, b, c : Double;
begin
   i := lb_SlicesGiven.ItemIndex;

   FPage.ActivePageIndex := 3;
   if (FsgVGrid.Tag <> FVMID) then
      ViewData();

   if ( (i >= 0) and (i < 48) (*true = m_pDB.GetVectorTable(dtp_Date.DateTime + EncodeTime(i div 2, (i mod 2)*30,0,0), PVMID, m_sVectors_48)*) ) then
   begin
   //---------------------------------------------------------------------------
   m_SID := i;
   for i := 0 to 5 do
      m_VD.m_Vectors[i].Value := 0;
    
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

  m_VD.m_Vectors[0].Value := 0.9;
  m_VD.m_Vectors[1].Value := 1;
  m_VD.m_Vectors[2].Value := 0.9;
  m_VD.m_Vectors[3].Value := 1;
  m_VD.m_Vectors[4].Value := 0.9;
  m_VD.m_Vectors[5].Value := 1;

  a := GetQuadrantAngle(m_sVectors_48.PA[m_SID], m_sVectors_48.QA[m_SID], ArcCos(m_sVectors_48.COSFA[m_SID])* 180 / PI);
  b := GetQuadrantAngle(m_sVectors_48.PB[m_SID], m_sVectors_48.QB[m_SID], ArcCos(m_sVectors_48.COSFB[m_SID])* 180 / PI);
  c := GetQuadrantAngle(m_sVectors_48.PC[m_SID], m_sVectors_48.QC[m_SID], ArcCos(m_sVectors_48.COSFC[m_SID])* 180 / PI);

  //if (a > 90) then a := a - 90;
  //if (b > 90) then b := b - 90;
  //if (c > 90) then c := c - 90;

  
  m_VD.m_Vectors[0].Angle := a / 180 * PI;
  m_VD.m_Vectors[1].Angle := 0;
  m_VD.m_Vectors[2].Angle := (120 + b) / 180 * PI;
  m_VD.m_Vectors[3].Angle := (120 / 180) * PI;
  m_VD.m_Vectors[4].Angle := (240 + c) / 180 * PI;
  m_VD.m_Vectors[5].Angle := (240 / 180) * PI;
  ap_VectorCanvas.Repaint();
//  m_VD.Paint();

   e_IA.Text := FloatToStrF(m_sVectors_48.IA[m_SID], ffFixed, 18, m_Precision);
   e_UA.Text := FloatToStrF(m_sVectors_48.UA[m_SID], ffFixed, 18, m_Precision);
   e_COSA.Text := FloatToStrF(m_sVectors_48.COSFA[m_SID], ffFixed, 18, m_Precision);
   e_PA.Text := FloatToStrF(m_sVectors_48.PA[m_SID], ffFixed, 18, m_Precision);
   e_QA.Text := FloatToStrF(m_sVectors_48.QA[m_SID], ffFixed, 18, m_Precision);

   e_IB.Text := FloatToStrF(m_sVectors_48.IB[m_SID], ffFixed, 18, m_Precision);
   e_UB.Text := FloatToStrF(m_sVectors_48.UB[m_SID], ffFixed, 18, m_Precision);
   e_COSB.Text := FloatToStrF(m_sVectors_48.COSFB[m_SID], ffFixed, 18, m_Precision);
   e_PB.Text := FloatToStrF(m_sVectors_48.PB[m_SID], ffFixed, 18, m_Precision);
   e_QB.Text := FloatToStrF(m_sVectors_48.QB[m_SID], ffFixed, 18, m_Precision);

   e_IC.Text := FloatToStrF(m_sVectors_48.IC[m_SID], ffFixed, 18, m_Precision);
   e_UC.Text := FloatToStrF(m_sVectors_48.UC[m_SID], ffFixed, 18, m_Precision);
   e_COSC.Text := FloatToStrF(m_sVectors_48.COSFC[m_SID], ffFixed, 18, m_Precision);
   e_PC.Text := FloatToStrF(m_sVectors_48.PC[m_SID], ffFixed, 18, m_Precision);
   e_QC.Text := FloatToStrF(m_sVectors_48.QC[m_SID], ffFixed, 18, m_Precision);

   e_PS.Text := FloatToStrF(m_sVectors_48.PS[m_SID], ffFixed, 18, m_Precision);
   e_QS.Text := FloatToStrF(m_sVectors_48.QS[m_SID], ffFixed, 18, m_Precision);

   sq := sqrt(m_sVectors_48.PS[m_SID]*m_sVectors_48.PS[m_SID]+m_sVectors_48.QS[m_SID]*m_sVectors_48.QS[m_SID]);
   e_S.Text := FloatToStrF(sq, ffFixed, 18, m_Precision);

   if sq <> 0 then
      e_KM.Text := FloatToStrF(m_sVectors_48.PS[m_SID] /sq, ffFixed, 18, m_Precision)
   else
      e_KM.Text := 'inf'; 

   e_Freq.Text := FloatToStrF(m_sVectors_48.FREQ[m_SID], ffFixed, 18, m_Precision);

   FsgVGrid.SelectRows(FindRow(FsgVGrid,IntToStr(m_SID+1)),1);
   FsgVGrid.Refresh();
   //---------------------------------------------------------------------------
   end
   else
      ShowMessage('Данные, необходимые для построения векторной диаграммы отсутствуют!');
end;

procedure TVectorFrame.dtp_DateChange(Sender: TObject);
var
//  a, b, c : Double;
//  l_Mult : TPoint;
  i : Integer;
begin
   lb_SlicesGiven.Items.Clear();

  if (true = m_pDB.GetVectorsTable_48(dtp_Date.DateTime, FVMID, m_sVectors_48)) then
  begin
    if (not m_WithKT and m_pDB.GetMMeterTable(FVMID, m_Meter)) then
    begin
      m_Meter.m_sfKI := m_Meter.m_sfKI;
      m_Meter.m_sfKU := m_Meter.m_sfKU;
    end else
    begin
      m_Meter.m_sfKI := 1;
      m_Meter.m_sfKU := 1;
    end;

    with m_sVectors_48 do
    for i:= 0 to 47 do
    begin
      FREQ[i]  := RVL(FREQ[i]);
      IA[i]    := RVL(IA[i] / m_Meter.m_sfKI);
      UA[i]    := RVL(UA[i] / m_Meter.m_sfKU);
      COSFA[i] := RVL(COSFA[i]);
      PA[i]    := RVL(PA[i] / m_Meter.m_sfKI / m_Meter.m_sfKU);
      QA[i]    := RVL(QA[i] / m_Meter.m_sfKI / m_Meter.m_sfKU);
      SA[i]    := RVL(SA[i] / m_Meter.m_sfKI / m_Meter.m_sfKU);

      IB[i]    := RVL(IB[i] / m_Meter.m_sfKI);
      UB[i]    := RVL(UB[i] / m_Meter.m_sfKU);
      COSFB[i] := RVL(COSFB[i]);
      PB[i]    := RVL(PB[i] / m_Meter.m_sfKI / m_Meter.m_sfKU);
      QB[i]    := RVL(QB[i] / m_Meter.m_sfKI / m_Meter.m_sfKU);
      SB[i]    := RVL(SB[i] / m_Meter.m_sfKI / m_Meter.m_sfKU);

      IC[i]    := RVL(IC[i] / m_Meter.m_sfKI);
      UC[i]    := RVL(UC[i] / m_Meter.m_sfKU);
      COSFC[i] := RVL(COSFC[i]);
      PC[i]    := RVL(PC[i] / m_Meter.m_sfKI / m_Meter.m_sfKU);
      QC[i]    := RVL(QC[i] / m_Meter.m_sfKI / m_Meter.m_sfKU);
      SC[i]    := RVL(SC[i] / m_Meter.m_sfKI / m_Meter.m_sfKU);

      PS[i]    := RVL(PS[i] / m_Meter.m_sfKI / m_Meter.m_sfKU);
      QS[i]    := RVL(QS[i] / m_Meter.m_sfKI / m_Meter.m_sfKU);
      SS[i]    := RVL(SS[i] / m_Meter.m_sfKI / m_Meter.m_sfKU);
      COSFS[i] := RVL(COSFS[i]);
    end;
    
    ValidateAndCalculate(m_sVectors_48);
    ViewData();
  end else
    m_Messages.Add('Данные отсутствуют.');
end;

procedure TVectorFrame.ViewData();
var
   i : Integer;
   l_EHH : Byte;
begin
   lb_SlicesGiven.Items.Clear();
   
      if cDateTimeR.CompareDayF(Now(), dtp_Date.DateTime) = 0 then // текущий день
         l_EHH := cDateTimeR.GetHH(Now())
      else
         l_EHH := 47;

      for i:= 0 to l_EHH do
      begin
         lb_SlicesGiven.Items.Add(Format('%.2d:%.2d', [i div 2, (i mod 2)*30]));


         FsgVGrid.Cells[0,1+i]  := IntToStr(i+1);
         FsgVGrid.Cells[1,1+i]  := FormatDateTime('dd.mm.yyyy', dtp_Date.DateTime);
         FsgVGrid.Cells[2,1+i]  := Format('%.2d:%.2d', [i div 2, (i mod 2)*30]);

         FsgVGrid.Cells[3,1+i]  := '-';
         FsgVGrid.Cells[4,1+i]  := FloatToStrF(m_sVectors_48.UA[i], ffFixed, 8,3);
         FsgVGrid.Cells[5,1+i]  := FloatToStrF(m_sVectors_48.UB[i], ffFixed, 8,3);
         FsgVGrid.Cells[6,1+i]  := FloatToStrF(m_sVectors_48.UC[i], ffFixed, 8,3);

         FsgVGrid.Cells[7,1+i]  := '-';
         FsgVGrid.Cells[8,1+i]  := FloatToStrF(m_sVectors_48.IA[i], ffFixed, 8,3);
         FsgVGrid.Cells[9,1+i]  := FloatToStrF(m_sVectors_48.IB[i], ffFixed, 8,3);
         FsgVGrid.Cells[10,1+i] := FloatToStrF(m_sVectors_48.IC[i], ffFixed, 8,3);

         FsgVGrid.Cells[11,1+i] := FloatToStrF(m_sVectors_48.COSFA[i], ffFixed, 8,3);
         FsgVGrid.Cells[12,1+i] := FloatToStrF(m_sVectors_48.COSFB[i], ffFixed, 8,3);
         FsgVGrid.Cells[13,1+i] := FloatToStrF(m_sVectors_48.COSFC[i], ffFixed, 8,3);

         {
         FsgVGrid.Cells[14,1+i] := FloatToStrF(m_sVectors_48.PS[i]*m_nP.m_sfKI*m_nP.m_sfKU, ffFixed, 8,3);
         FsgVGrid.Cells[15,1+i] := FloatToStrF(m_sVectors_48.PA[i]*m_nP.m_sfKI*m_nP.m_sfKU, ffFixed, 8,3);
         FsgVGrid.Cells[16,1+i] := FloatToStrF(m_sVectors_48.PB[i]*m_nP.m_sfKI*m_nP.m_sfKU, ffFixed, 8,3);
         FsgVGrid.Cells[17,1+i] := FloatToStrF(m_sVectors_48.PC[i]*m_nP.m_sfKI*m_nP.m_sfKU, ffFixed, 8,3);

         FsgVGrid.Cells[18,1+i] := FloatToStrF(m_sVectors_48.QS[i]*m_nP.m_sfKI*m_nP.m_sfKU, ffFixed, 8,3);
         FsgVGrid.Cells[19,1+i] := FloatToStrF(m_sVectors_48.QA[i]*m_nP.m_sfKI*m_nP.m_sfKU, ffFixed, 8,3);
         FsgVGrid.Cells[20,1+i] := FloatToStrF(m_sVectors_48.QB[i]*m_nP.m_sfKI*m_nP.m_sfKU, ffFixed, 8,3);
         FsgVGrid.Cells[21,1+i] := FloatToStrF(m_sVectors_48.QC[i]*m_nP.m_sfKI*m_nP.m_sfKU, ffFixed, 8,3);
         }


         FsgVGrid.Cells[14,1+i] := FloatToStrF(m_sVectors_48.PS[i], ffFixed, 8,3);
         FsgVGrid.Cells[15,1+i] := FloatToStrF(m_sVectors_48.PA[i], ffFixed, 8,3);
         FsgVGrid.Cells[16,1+i] := FloatToStrF(m_sVectors_48.PB[i], ffFixed, 8,3);
         FsgVGrid.Cells[17,1+i] := FloatToStrF(m_sVectors_48.PC[i], ffFixed, 8,3);

         FsgVGrid.Cells[18,1+i] := FloatToStrF(m_sVectors_48.QS[i], ffFixed, 8,3);
         FsgVGrid.Cells[19,1+i] := FloatToStrF(m_sVectors_48.QA[i], ffFixed, 8,3);
         FsgVGrid.Cells[20,1+i] := FloatToStrF(m_sVectors_48.QB[i], ffFixed, 8,3);
         FsgVGrid.Cells[21,1+i] := FloatToStrF(m_sVectors_48.QC[i], ffFixed, 8,3);

         FsgVGrid.Cells[22,1+i] := FloatToStrF(m_sVectors_48.FREQ[i], ffFixed, 8,3);
      end;
      FsgVGrid.Tag := FVMID;
//      SetHigthGrid(m_RowSize);
end;


procedure TVectorFrame.OnFormResize(Sender: TObject);
begin
  dtp_Date.Left := Self.ClientWidth - (dtp_Date.Width + dtp_Date.Top);

  if (m_VDInit) then
  begin
    if (ap_VectorCanvas.Width > ap_VectorCanvas.Height) then
      m_VD.SideLenght := ap_VectorCanvas.Height
    else
      m_VD.SideLenght := ap_VectorCanvas.Width;
    ap_VectorCanvas.Repaint();
    //    m_VD.Paint();
  end;
end;

procedure TVectorFrame.cb_PrecisionChange(Sender: TObject);
begin
  m_Precision := cb_Precision.ItemIndex;
end;



function TVectorFrame.ValidateAndCalculate(var _V : SL3Vectors_48) : Boolean;
var
  l_AngleA, l_AngleB, l_AngleC : Double;
  l_Mes : String;
  i : Integer;
begin
  Result := false;

  with _V do
  if ((_V.DataMask AND c_IUFC)=c_IUFC) then // пришли данные I, U, FREQ, COS(ф)
  begin
    m_Messages.Add('Параметры I, U, cos Ф, f являются условно одновременными.');
    m_Messages.Add('Параметры Ф, P, Q, S, Pсум, Qсум, Sсум, cos Ф являются расчетными.');
    m_Messages.Add('В значениях параметров отброшены ' + c_Precisions[m_Precision] + 'знаки после запятой.');
    m_Messages.Add('Векторная диаграмма отображена исходя из предположения, что тип нагрузки индуктивный');
    m_Messages.Add('Квадрант P+ Q-');
    Result := true;
    for i:=0 to 47 do
    begin
      l_AngleA := ArcCos(COSFA[i])* 180 / PI;
      l_AngleB := ArcCos(COSFB[i])* 180 / PI;
      l_AngleC := ArcCos(COSFC[i])* 180 / PI;

      if (l_AngleA > 90) then l_AngleA := l_AngleA - 90;
      if (l_AngleB > 90) then l_AngleB := l_AngleB - 90;
      if (l_AngleC > 90) then l_AngleC := l_AngleC - 90;

      l_AngleA := l_AngleA * PI / 180;
      l_AngleB := l_AngleB * PI / 180;
      l_AngleC := l_AngleC * PI / 180;

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

      if SS[i] <> 0 then
        COSFS[i] := RVL(PS[i]/SS[i])
      else
        COSFS[i] := 0;
    end;
  end
  else if ((_V.DataMask AND c_PQIUF)=c_PQIUF) then // пришли данные P, Q, I, U, FREQ
  begin
    m_Messages.Add('Параметры I, U, P, Q, f являются условно-одновременными.');
    m_Messages.Add('Параметры S, cos Ф, Ф, Pсум, Qсум, Sсум, cos Фсум являются расчетными.');
    m_Messages.Add('В значениях параметров отброшены ' + c_Precisions[m_Precision] + 'знаки после запятой.');
    Result := true;

    for i:=0 to 47 do
    begin
      // рассчитаем полные мощности на фазах
      SA[i] := RVL(sqrt(PA[i]*PA[i] + QA[i]*QA[i]));
      SB[i] := RVL(sqrt(PB[i]*PB[i] + QB[i]*QB[i]));
      SC[i] := RVL(sqrt(PC[i]*PC[i] + QC[i]*QC[i]));

      PS[i] := (PA[i] + PB[i] + PC[i]);
      QS[i] := (QA[i] + QB[i] + QC[i]);
      SS[i] := (SA[i] + SB[i] + SC[i]);

      // рассчитаем коэффициенты мощности на фазах
      if (SA[i] <> 0) then COSFA[i] := RVL(PA[i] / SA[i]);
      if (SB[i] <> 0) then COSFB[i] := RVL(PB[i] / SB[i]);
      if (SC[i] <> 0) then COSFC[i] := RVL(PC[i] / SC[i]);
      if (SS[i] <> 0) then COSFS[i] := RVL(PS[i] / SS[i]);

      if (UA[i] <> 0) then IA[i] := RVL(SA[i] / UA[i] * 1000);
      if (UB[i] <> 0) then IB[i] := RVL(SB[i] / UB[i] * 1000);
      if (UC[i] <> 0) then IC[i] := RVL(SC[i] / UC[i] * 1000);

      l_Mes := 'Квадрант ';
      if (PS[i] >= 0) then
        l_Mes := l_Mes+'P+'
      else
        l_Mes := l_Mes+'P-';
      if (QS[i] >= 0) then
        l_Mes := l_Mes+' Q+'
      else
        l_Mes := l_Mes+' Q-';
    end;
    m_Messages.Add(l_Mes);
  end else if (_V.DataMask = 0) then
    m_Messages.Add('Данные отсутствуют')
  else
    m_Messages.Add('Данные не достоверны.');
  Result := true;
end;




function TVectorFrame.GetQuadrantAngle(_P,_Q,_Angle : Double) : Double;
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

procedure TVectorFrame.FormDestroy(Sender: TObject);
begin
  m_Messages.Destroy();
  m_VD.Destroy();
end;

procedure TVectorFrame.ap_VectorCanvasPaint(Sender: TObject; ACanvas: TCanvas; ARect: TRect);
var
  l_LineWidth  :Integer;
begin
  l_LineWidth := 1;
  if (m_VDInit) then
  begin
    if (ap_VectorCanvas.Width > ap_VectorCanvas.Height) then
      m_VD.SideLenght := ap_VectorCanvas.Height
    else
      m_VD.SideLenght := ap_VectorCanvas.Width;

    m_VD.UseBitmap(ACanvas);
    m_VD.Paint();
  end;
end;

end.
