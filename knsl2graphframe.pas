unit knsl2graphframe;
{$DEFINE MINSK_ENERGO_DEBUG}

//  Внимание!!! Для перехода на старую версию нужно убрать преффикс WithTarif во всех записях CCDatasWithTarif


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Grids, BaseGrid, AdvGrid, TeEngine, Series, TeeProcs,
  Chart, RbDrawCore, RbButton, jpeg, ExtCtrls, ToolWin, ImgList,utltypes,
  utlbox,utlconst,utldatabase, printers,knsl3recalcmodule,knslProgressLoad,AdvOfficePager,
  AdvToolBar, AdvToolBarStylers, AdvAppStyler, AdvPanel,knsl5config,knsl4secman,
  AdvOfficeButtons, AdvGroupBox, Menus, AdvMenus, AdvMenuStylers,
  AdvGlowButton;

type
  TGraphFrame = class(TForm)
    imgEditPannel: TImageList;
    imgGFrame: TImageList;
    FchChart: TChart;
    lbT1: TLabel;
    lbT2: TLabel;
    lbT3: TLabel;
    lbT4: TLabel;
    lbT1Min: TLabel;
    lbT1Max: TLabel;
    lbT1Sum: TLabel;
    lbT2Min: TLabel;
    lbT2Max: TLabel;
    lbT2Sum: TLabel;
    lbT3Min: TLabel;
    lbT3Max: TLabel;
    lbT3Sum: TLabel;
    lbT4Min: TLabel;
    lbT4Max: TLabel;
    lbT4Sum: TLabel;
    lbShowValue: TLabel;
    lbTSSum: TLabel;
    Series1: TBarSeries;
    Series2: TLineSeries;
    AdvPanel1: TAdvPanel;
    AdvPanel2: TAdvPanel;
    cbTariff: TComboBox;
    lbValidData: TLabel;
    lbMin: TLabel;
    lbMax: TLabel;
    lbSum: TLabel;
    lbGSum: TLabel;
    dtPic1: TDateTimePicker;
    dtPic2: TDateTimePicker;
    AdvPanelStyler1: TAdvPanelStyler;
    GraphStyler: TAdvFormStyler;
    AdvToolBar1: TAdvToolBar;
    AdvToolBarOfficeStyler1: TAdvToolBarOfficeStyler;
    advRadioGroup: TAdvOfficeRadioGroup;
    advLeftClickMenu: TAdvPopupMenu;
    AdvMenuOfficeStyler1: TAdvMenuOfficeStyler;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    AdvGlowMenuButton1: TAdvGlowMenuButton;
    advTopMenu: TAdvPopupMenu;
    N4: TMenuItem;
    N5: TMenuItem;
    N9: TMenuItem;
    AdvGlowMenuButton2: TAdvGlowMenuButton;
    advDataMenu: TAdvPopupMenu;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    AdvGlowMenuButton3: TAdvGlowMenuButton;
    advViewData: TAdvPopupMenu;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    nTariff: TMenuItem;
    N6: TMenuItem;
    procedure OnCloseCForm(Sender: TObject; var Action: TCloseAction);
    procedure OnCloseP(Sender: TObject);
    procedure OnResizeGraph(Sender: TObject);
    procedure OnCreateGFrame(Sender: TObject);
    procedure OnUpdateData(Sender: TObject);
    procedure OnLoadCounter(Sender: TObject);
    procedure OnStopQuery(Sender: TObject);
    procedure dtPic1Change(Sender: TObject);
    procedure OnDelete(Sender: TObject);
    procedure OnPic2Chandge(Sender: TObject);
    procedure OnPrintSlice(Sender: TObject);
    procedure OnUpdateArch(Sender: TObject);
    procedure OnDbClickGraph(Sender: TObject);
    procedure OnLoadAllMeter(Sender: TObject);
    procedure FchChartMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FchChartClickSeries(Sender: TCustomChart;
      Series: TChartSeries; ValueIndex: Integer; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OnChangeKindGr(Sender: TObject);
    procedure OnDellAll(Sender: TObject);
    procedure OnPowerView(Sender: TObject);
    procedure OnClearAll(Sender: TObject);
    procedure Upd(Sender: TObject);
    function  GetColorForSlice(ColorIndex, SlN : integer;
                                       Mask    : int64;
                                       Date    : TDateTime) : TColor;
    function  PrepVoltSumData(var m_pData: CCDatasWithTarif): boolean;
    function  PrepCurrSummData(var m_pData: CCDatasWithTarif): boolean;
    procedure PaintGraphSliceKIKUClick(Sender: TObject);

    procedure ToolButton2Click(Sender: TObject);
    procedure OnReCalc(Sender: TObject);
    procedure OnChangeRadio(Sender: TObject);
    procedure OnLoadOneTUCH(Sender: TObject);
    procedure OnFindAllTUCH(Sender: TObject);
    procedure OnFindOneTUCH(Sender: TObject);
    procedure OnSetNoValid(Sender: TObject);
    procedure OnSetValid(Sender: TObject);
    procedure OnDeleteSlice(Sender: TObject);
    procedure SendQSDataEx(nCommand,snAID,snMid,nCMDID:Integer;sdtBegin,sdtEnd:TDateTime);
    procedure SendQSData(nCommand,snSRVID,nCMDID:Integer;sdtBegin,sdtEnd:TDateTime);
    procedure OnTcMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure nTariffClick(Sender: TObject);
  private
    { Private declarations }
    DarkColors   : array [0..4] of TColor;
    LightColors  : array [0..4] of TColor;
    ViewIndex    : byte;
    FPage        : TAdvOfficePager;
    FABOID       : Integer;
    FIndex       : Integer;             //Индитефикатор параметра
    FMasterIndex : Integer;             //Индитефикатор виртуального счетчика
    FPHAddres    : Integer;             //Физический ардес(УДЛ VMID)
    FMID         : Integer;             //Физический счетчик
    FPRID        : Integer;
    FTID         : Integer;
    FMTID        : Integer;             //Тип счетчика;
    FPLID        : Integer;
    FSVStatus    : Integer;
    FCLStatus    : Integer;
    FLocation    : Integer;
    FsgPGrid     : PTAdvStringGrid;
    FsgEGrid     : PTAdvStringGrid;
    m_pMetaTbl   : CGRMetaData;
    m_pData      : CCDatasWithTarif;
    m_pData_CUR  : L3CURRENTDATAS;

    m_pGrData    : L3GRAPHDATAS;
    m_pTariffs   : TM_TARIFFS;
    FActive      : Boolean;
    MouseM       : SMouseM;
    m_blPower    : Boolean;
    b_KiKu       : Boolean;
    m_blInFocus  : Boolean;
    m_nValIndex  : Integer;
    m_nRowIndex  : Integer;

    procedure OnLoadAllMeter_Old(wFind:Word);
    function  IsGraph:Boolean;
    procedure LoadSettings;
    procedure PaintGraphSlice();
    procedure PaintGraphArch();
    procedure PaintGraphArchKIKU();
    function  GetColorFromTariffs(Srez:byte;var pTable:TM_TARIFFS):Byte;
    procedure DrawLabels();
    procedure InitPeriodic();
    procedure InitSlice();
    procedure InitArch();
    function  FindRow(pGrid:PTAdvStringGrid;str:String):Integer;
    procedure ReplaceIsPower;
    procedure PaintGraphSliceKIKU();
    procedure ControlCRC(pTab:L3GRAPHDATAS); overload;
    procedure ControlCRC(pTab:CCDatasWithTarif);   overload;
    function ReturnCRC(m_sfValue:array of double):word;
    procedure SendRemCrcQry(nPort:Byte;var pDS:CMessageData);
    procedure SendDelCrcQry(nPort:Byte;var pDS:CMessageData);
    procedure StartFind(nCMD:Integer;blFind,blOne:Boolean);
    function  IsParam4(nCMDID:Integer;var nOutCmd:Integer):Boolean;
    function  GetMaskFromCode(nCMD:Integer;blFind:Boolean;var pDS:CMessageData):int64;
    function  ChangeColor(InputColor : TColor; Value : byte) : TColor;
 //   procedure InitProgress;
  public
    procedure Init;
    procedure ViewData;
    procedure ViewSlice;
    procedure ViewArchive;
    procedure ViewTableArch(var pTbl:CCDatasWithTarif);
    procedure ViewTableArchKIKU(var pTbl:CCDatasWithTarif);
    procedure ViewTableSlice(var Tbl:L3GRAPHDATAS);
    procedure ViewTableSliceKIKU(var Tbl:L3GRAPHDATAS);
    procedure ViewTableArchE();
    procedure ViewTableSliceE();
    procedure ViewTableSliceKIKUE();
    procedure ClearTableArch();
    procedure OutTextOnPrinter(x, y : single;var str : string; var PrinterI:TPrinter);
    procedure nTarrCheck(Checked : Boolean);
    procedure cloneRow(rowIndex:Integer);
    procedure createRow(rowIndex:Integer);
    procedure saveRow(rowIndex:Integer);
    procedure saveRowAllTariff(rowIndex:Integer);    
    function  FindFreeRow(pGrid:PTAdvStringGrid;nIndex:Integer):Integer;
  public
    { Public declarations }
    property PPage        : TAdvOfficePager    read FPage        write FPage;
    property PABOID       : Integer         read FABOID       write FABOID;
    property PIndex       : Integer         read FIndex       write FIndex;
    property PMasterIndex : Integer         read FMasterIndex write FMasterIndex;
    property PMID         : Integer         read FMID         write FMID;
    property PPRID        : Integer         read FPRID        write FPRID;
    property PTID         : Integer         read FTID         write FTID;
    property PSVStatus    : Integer         read FSVStatus    write FSVStatus;
    property PCLStatus    : Integer         read FCLStatus    write FCLStatus;
    property PActive      : Boolean         read FActive      write FActive;
    property PsgPGrid     : PTAdvStringGrid read FsgPGrid     write FsgPGrid;
    property PsgEGrid     : PTAdvStringGrid read FsgEGrid     write FsgEGrid;
  end;

var
  GraphFrame: TGraphFrame;
  nAVMid  : Integer;
  nAParam : Integer;
  nActSVStat : Integer;

implementation


{$R *.DFM}
{$o-}
procedure TGraphFrame.Init;
Begin
   //m_pDB.GetMeterLocation(FMID,FLocation);
   FMTID := 2;
   m_pDB.GetMeterType(FMasterIndex,FMTID,FPLID);
   m_pDB.GetMeterLocation(FMID,FLocation,FPHAddres);
   nAParam := FIndex;
   nAVMid  := FMasterIndex;
   DarkColors[0] := clBlue; DarkColors[1] := clGreen;
   DarkColors[2] := clRed;  DarkColors[3] := clPurple;
   LightColors[0] := ChangeColor(clBlue, 210); LightColors[1] := ChangeColor(clGreen, 210);
   LightColors[2] := ChangeColor(clRed, 210); LightColors[3] := ChangeColor(clPurple, 210);
End;
procedure TGraphFrame.InitArch();
begin
   advRadioGroup.Visible := false;
   lbT1.Visible     := false;
   lbT2Sum.Visible  := false;
   lbT2Min.Visible  := false;
   lbT2Max.Visible  := false;
   lbT2.Visible     := false;
   lbT3Sum.Visible  := false;
   lbT3Min.Visible  := false;
   lbT3Max.Visible  := false;
   lbT3.Visible     := false;
   lbT4Sum.Visible  := false;
   lbT4Min.Visible  := false;
   lbT4Max.Visible  := false;
   lbT4.Visible     := false;
   cbTariff.Visible := false;//   cbTariff.Visible := true;
   //lbTariff.Visible := true;

end;
procedure TGraphFrame.InitPeriodic();
begin
   advRadioGroup.Visible := false;
   lbT1.Visible     := false;
   lbT2Sum.Visible  := false;
   lbT2Min.Visible  := false;
   lbT2Max.Visible  := false;
   lbT2.Visible     := false;
   lbT3Sum.Visible  := false;
   lbT3Min.Visible  := false;
   lbT3Max.Visible  := false;
   lbT3.Visible     := false;
   lbT4Sum.Visible  := false;
   lbT4Min.Visible  := false;
   lbT4Max.Visible  := false;
   lbT4.Visible     := false;

   lbSum.Visible    := false;
   lbT1Sum.Visible  := false;

   cbTariff.Visible := False;
   //nTariffClick(self);
   nTarrCheck(false);
   //lbTariff.Visible := False;

end;

procedure TGraphFrame.InitSlice();
begin
   advRadioGroup.Visible := True;

   if nTariff.Checked=True then
   Begin
   lbT1.Visible     := true;

   lbT1Min.Visible  := true;
   lbT1Max.Visible  := true;
   lbT1.Visible     := true;

   lbT2Min.Visible  := true;
   lbT2Max.Visible  := true;
   lbT2.Visible     := true;

   //lbT3Sum.Visible  := true;
   lbT3Min.Visible  := true;
   lbT3Max.Visible  := true;
   lbT3.Visible     := true;


   lbT4Min.Visible  := true;
   lbT4Max.Visible  := true;
   lbT4.Visible     := true;

   cbTariff.Visible := false;
   //lbTariff.Visible := false;


   if m_blPower=True then
   Begin
    lbT1Sum.Visible  := False;
    lbT2Sum.Visible  := False;
    lbT3Sum.Visible  := False;
    lbT4Sum.Visible  := False;
    lbSum.Visible    := False;
    lbTSSum.Visible  := False;
    lbGSum.Visible   := False;
    //lbMax.Visible   := False;
   End else
   if m_blPower=False then
   Begin
    lbT1Sum.Visible  := True;
    lbT2Sum.Visible  := True;
    lbT3Sum.Visible  := True;
    lbT4Sum.Visible  := True;
    lbTSSum.Visible  := True;
    lbGSum.Visible   := True;
    lbSum.Visible    := True;
   End;
   End;
end;

procedure TGraphFrame.DrawLabels();
Var
   strS  : String;
   nFind : Integer;
begin
   lbT1Min.Caption := '0.000'; lbT1Max.Caption := '0.000'; lbT1Sum.Caption := '0.000';
   lbT2Min.Caption := '0.000'; lbT2Max.Caption := '0.000'; lbT2Sum.Caption := '0.000';
   lbT3Min.Caption := '0.000'; lbT3Max.Caption := '0.000'; lbT3Sum.Caption := '0.000';
   lbT4Min.Caption := '0.000'; lbT4Max.Caption := '0.000'; lbT4Sum.Caption := '0.000';
   {
   FchChart.Title.Text.Clear;
   if m_blPower=True then
   Begin
    strS := Caption;
    nFind := Pos(':',strS);
    Delete(strS,nFind+1,Length(strS)-nFind);
    case FIndex of
     QRY_SRES_ENR_EP:m_pMetaTbl.m_sName:='Пот.акт.мт.(P+)';
     QRY_SRES_ENR_EM:m_pMetaTbl.m_sName:='Выд.акт.мт.(P-)';
     QRY_SRES_ENR_RP:m_pMetaTbl.m_sName:='Пот.реа.мт.(Q+)';
     QRY_SRES_ENR_RM:m_pMetaTbl.m_sName:='Пот.реа.мт.(Q-)';
    End;
    FchChart.Title.Text.Add(Caption);
   End else FchChart.Title.Text.Add(Caption);
   }
end;
function  TGraphFrame.GetColorFromTariffs(Srez:byte; var pTable:TM_TARIFFS):Byte;
var SumS                         : word;
    Hour0, Min0, Sec0, ms0, Sum0 : word;
    Hour1, Min1, Sec1, ms1, Sum1 : word;
    i                            : byte;
begin
    Result := 0;
    SumS   := 30 * Srez;
    try
    for i := 1 to pTable.Count - 1 do
    begin
      DecodeTime(pTable.Items[i].m_dtTime0, Hour0, Min0, Sec0, ms0);
      DecodeTime(pTable.Items[i].m_dtTime1, Hour1, Min1, Sec1, ms1);
      Sum0 := Hour0*60 + Min0;
      Sum1 := Hour1*60 + Min1;
      if Hour0 < Hour1 then
      begin
        if ((SumS >= Sum0) and (SumS < Sum1)) then
          Result := pTable.Items[i].m_swPTID;
      end
      else
      begin
        if SumS >= Sum0 then
          Result := pTable.Items[i].m_swPTID;
        if SumS < Sum1 then
          Result := pTable.Items[i].m_swPTID;
      end;
    end;
    except
//     TraceER('(__)CERMD::>Error In TGraphFrame.GetColorFromTariffs!!!');
    end;
end;

procedure TGraphFrame.OnCreateGFrame(Sender: TObject);
begin

     LoadSettings;
     cbTariff.ItemIndex := 0;
     //m_pDB.GetMeterLocation(FMID,FLocation,FPHAddres);
     m_blPower := True;
     if nTariff.Checked=True then
     Begin
     lbT1Sum.Visible  := True;
     lbT2Sum.Visible  := True;
     lbT3Sum.Visible  := True;
     lbT4Sum.Visible  := True;
     lbTSSum.Visible  := True;
     lbGSum.Visible   := True;
     lbSum.Visible    := True;
     lbGSum.Visible   := False;
     lbTSSum.Visible   := False;
     //lbMax.Visible   := False;
     lbGSum.Visible   := False;
     lbTSSum.Visible   := False;
     //lbMax.Visible   := False;
     End;

     ViewIndex        := 0;
     b_KiKu := False;
     DrawLabels;
end;
procedure TGraphFrame.LoadSettings;
Begin
     //OnResizeGraph(Owner);
     dtPic1.DateTime := Now;
     dtPic2.DateTime := Now;
     DrawLabels;
     lbShowValue.Visible := false;
     m_nCF.m_nSetColor.PGraphStyler := @GraphStyler;
     m_nCF.m_nSetColor.SetAllStyle(m_nCF.StyleForm.ItemIndex);
     //GetGMetaData(nIndex:Integer;var pTable:CGRMetaData);
End;
procedure TGraphFrame.OnResizeGraph(Sender: TObject);
var
  nSize:Integer;
begin

     dtPic1.Left   := FchChart.Width-10-dtPic1.Width;
     dtPic2.Left   := dtPic1.Left-dtPic1.Width-10;
     //lbPeriod.Left := dtPic2.Left-lbPeriod.Width-10;

     cbTariff.Left := dtPic2.Left-cbTariff.Width-10;
     //lbTariff.Left := cbTariff.Left-lbTariff.Width-10;

     //lbMin.Left    := tbVGraph.Left - 3*50;
     lbMin.Left    := trunc(FchChart.Left+100) + 1*80;
     lbMax.Left    := trunc(FchChart.Left+100) + 2*80;
     lbSum.Left    := trunc(FchChart.Left+100) + 3*80;
     lbTSSum.Left  := trunc(FchChart.Left+100) + 4*80;
     lbGSum.Left   := lbTSSum.Left;

     lbT1.Left     := lbMin.Left-25;
     lbT2.Left     := lbMin.Left-25;
     lbT3.Left     := lbMin.Left-25;
     lbT4.Left     := lbMin.Left-25;

     lbT1Min.Left  := lbMin.Left;
     lbT2Min.Left  := lbMin.Left;
     lbT3Min.Left  := lbMin.Left;
     lbT4Min.Left  := lbMin.Left;

     lbT1Max.Left  := lbMax.Left;
     lbT2Max.Left  := lbMax.Left;
     lbT3Max.Left  := lbMax.Left;
     lbT4Max.Left  := lbMax.Left;

     lbT1Sum.Left  := lbSum.Left;
     lbT2Sum.Left  := lbSum.Left;
     lbT3Sum.Left  := lbSum.Left;
     lbT4Sum.Left  := lbSum.Left;

     //lbTSSum.Left  := lbGSum.Left;

     //Top
     //lbT4.Top      := FchChart.Height - lbT4.Height;
     //lbT4Min.Top   := lbT4.Top;
     //lbT4Max.Top   := lbT4.Top;
     //lbT4Sum.Top   := lbT4.Top;

     lbT4.Top      := FchChart.Height - lbT4.Height+3;
     lbT4Min.Top   := lbT4.Top;
     lbT4Max.Top   := lbT4.Top;
     lbT4Sum.Top   := lbT4.Top;

     lbT3.Top      := lbT4.Top-1*(lbT4.Height);
     lbT3Min.Top   := lbT4.Top-1*(lbT4.Height);
     lbT3Max.Top   := lbT4.Top-1*(lbT4.Height);
     lbT3Sum.Top   := lbT4.Top-1*(lbT4.Height);

     lbT2.Top      := lbT4.Top-2*lbT4.Height;
     lbT2Min.Top   := lbT4.Top-2*lbT4.Height;
     lbT2Max.Top   := lbT4.Top-2*lbT4.Height;
     lbT2Sum.Top   := lbT4.Top-2*lbT4.Height;

     lbT1.Top      := lbT4.Top-3*lbT4.Height;
     lbT1Min.Top   := lbT4.Top-3*lbT4.Height;
     lbT1Max.Top   := lbT4.Top-3*lbT4.Height;
     lbT1Sum.Top   := lbT4.Top-3*lbT4.Height;

     lbTSSum.Top   := lbT4.Top;

     nSize := trunc(AdvToolBar1.Width/3)-7;
     AdvGlowMenuButton2.Width := nSize;
     AdvGlowMenuButton3.Width := nSize;
     //lbMin.Top     := lbT3.Top-3*lbT3.Height;
     //lbMax.Top     := lbT3.Top-3*lbT3.Height;
     //lbSum.Top     := lbT3.Top-3*lbT3.Height;
end;

procedure TGraphFrame.OnCloseCForm(Sender: TObject;
  var Action: TCloseAction);
begin
    Action := caFree;
    m_nCF.m_nSetColor.PGraphStyler := nil;
end;
procedure TGraphFrame.OnCloseP(Sender: TObject);
begin
    FPage.ActivePageIndex := 1;
end;

function  TGraphFrame.GetColorForSlice(ColorIndex, SlN : integer;
                                       Mask            : int64;
                                       Date : TDateTime) : TColor;
var IsBit  : boolean;
    _30Min : TDateTime;
begin
   _30Min := EncodeTime(0, 30, 0, 0);
   Result := clBlack;
   IsBit := IsBitInMask(Mask, SlN);
   if (trunc(Date) = trunc(Now)) and (trunc(Date) + (SlN + 1)* _30Min > Now) then
     IsBit := true;
   if IsBit then
   begin
     Result := DarkColors[ColorIndex];
     if lbValidData.Font.Color = clBlack + 1 then
     begin
       lbValidData.Caption      := 'Данные достоверны';
       lbValidData.Font.Color   := clBlack;
     end;
   end
   else
   begin
     if lbValidData.Font.Color <> clRed then
     begin
       lbValidData.Caption    := 'Данные не достоверны';
       lbValidData.Font.Color := clRed;
     end;
     Result := LightColors[ColorIndex];
   end;

end;

function TGraphFrame.PrepVoltSumData(var m_pData: CCDatasWithTarif): boolean;
var m_VPhA : CCDatasWithTarif;
    res    : boolean;
    i      : integer;
begin
   res := m_pDB.GetGDPData(dtPic1.DateTime,dtPic2.DateTime,FMasterIndex,QRY_U_PARAM_A,m_VPhA);
   m_pData.Count := m_VPhA.Count;
   SetLength(m_pData.Items, m_pData.Count);
   for i := 0 to m_VphA.Count - 1 do
   begin
     m_pData.Items[i].m_sfValue := m_VPhA.Items[i].m_sfValue * sqrt(3);
     m_pData.Items[i].m_sTime := m_VPhA.Items[i].m_sTime;
   end;
   Result := res;
end;

function TGraphFrame.PrepCurrSummData(var m_pData: CCDatasWithTarif): boolean;
var m_CPh                  : array [0..2] of CCDatasWithTarif;
    res                    : array [0..2] of boolean;
    minCount, i, j         : integer;
    maxVal                 : double;
begin
   res[0] := m_pDB.GetGDPData(dtPic1.DateTime,dtPic2.DateTime,FMasterIndex,QRY_I_PARAM_A,m_CPh[0]);
   res[1] := m_pDB.GetGDPData(dtPic1.DateTime,dtPic2.DateTime,FMasterIndex,QRY_I_PARAM_B,m_CPh[1]);
   res[2] := m_pDB.GetGDPData(dtPic1.DateTime,dtPic2.DateTime,FMasterIndex,QRY_I_PARAM_C,m_CPh[2]);
   minCount := 0;
   for i := 0 to 2 do
     if minCount < m_CPh[i].Count then
       minCount := m_CPh[i].Count;

   m_pData.Count := minCount;
   SetLength(m_pData.Items, minCount);

   for i := 0 to minCount - 1 do
   begin
     maxVal := 0;
     for j := 0 to 2 do
       if m_CPh[j].Items[i].m_sfValue > maxVal then
         maxVal := m_CPh[j].Items[i].m_sfValue;
     m_pData.Items[i].m_sfValue := maxVal;
     m_pData.Items[i].m_sTime := m_CPh[0].Items[i].m_sTime;
   end;

   Result := res[0] and res[1] and res[2];
end;


procedure TGraphFrame.PaintGraphSlice();
var i, j, k     : integer;
    Index       : Integer;
    str         : string;
    Color       : TColor;
    IsInst      : array [0..3] of boolean;
    min, max    : array [0..3] of Double;
    sum         : array [0..3] of Double;
    param       : Double;
begin
    //b_KiKu := False;
    //Index := advRadioGroup.ItemIndex;
    DrawLabels;                                                        // JKLJKL
    for i := 0 to 3 do begin IsInst[i] := false; sum[i] := 0; end;
    if FIndex=QRY_RASH_HOR_V then
    k := FIndex - QRY_RASH_HOR_V + 1 else
    k := FIndex - QRY_SRES_ENR_EP + 1;
    //if m_blPower=True  then m_pDB.GetTMTarPeriodsCmdTable(FMasterIndex,FIndex,m_pTariffs);
    //if m_blPower=False then m_pDB.GetRealTMTarPeriodsPlaneTable(FMasterIndex,FIndex,m_pTariffs);
    //if m_blPower=True  then m_pDB.GetTMTarPeriodsTable(FMasterIndex, FTID+4, m_pTariffs);
    //if m_blPower=False then m_pDB.GetTMTarPeriodsTable(FMasterIndex, FTID, m_pTariffs);
    k := 0;
    {$IFDEF MINSK_ENERGO_DEBUG}
    if m_pGrData.Count = 1 then
      FchChart.BottomAxis.LabelsSeparation := 10
    else
      FchChart.BottomAxis.LabelsSeparation := 0;
    {$ENDIF}
    for i:=0 to m_pGrData.Count-1 do
    begin
    if m_blPower=True  then m_pDB.GetTMTarPeriodsCmdTable(m_pGrData.Items[i].m_sdtDate,FMasterIndex,FIndex,4,m_pTariffs);
    if m_blPower=False then m_pDB.GetTMTarPeriodsCmdTable(m_pGrData.Items[i].m_sdtDate,FMasterIndex,FIndex,0,m_pTariffs);//m_pDB.GetRealTMTarPeriodsPlaneTable(m_pGrData.Items[i].m_sdtDate,FMasterIndex,FIndex,m_pTariffs);
     for j:=0 to 47 do
     begin
      //if m_blPower=True then  m_pGrData.Items[i].v[j] := 2*m_pGrData.Items[i].v[j];
      param := m_pGrData.Items[i].v[j];
      if (j mod 2=0)and(advRadioGroup.ItemIndex=1) then param := m_pGrData.Items[i].v[j]+m_pGrData.Items[i].v[j+1];
      if (j mod 2=1)and(advRadioGroup.ItemIndex=1) then continue;
      if (m_blPower=True)and(advRadioGroup.ItemIndex=0) then param := 2*param;

      Index := GetColorFromTariffs(j, m_pTariffs) - 1;
      sum[Index] := sum[Index] +  param;
      if not IsInst[Index] then
      begin
       min[Index] := param;
       max[Index] := param;
       IsInst[Index] := true;
      end;
      if param < min[Index] then min[Index] := param;
      if param > max[Index] then max[Index] := param;
      if advRadioGroup.ItemIndex=0 then
      begin
        str := IntToStr((j + 1) div 2) + ':';
        if (j + 1) mod 2 = 0 then str := str + '00' else str := str + '30'
      end
      else
      begin
        str := IntToStr((j + 2) div 2) + ':';
        if (j + 2) mod 2 = 0 then str := str + '00' else str := str + '30'
      end;
      Inc(k);

      //if (FMTID = MET_SUMM) or (FMTID = MET_GSUMM) then
        Color := GetColorForSlice(Index, j, m_pGrData.Items[i].m_sMaskReRead, m_pGrData.Items[i].m_sdtDate);
      //else
      //  Color := GetColorForSlice(Index, j, m_pGrData.Items[i].m_sMaskRead, m_pGrData.Items[i].m_sdtDate);

      //FchChart.Series[ViewIndex].YValue[k] := param;
      if m_pGrData.Count = 1 then
        if j <> 0 then FchChart.Series[ViewIndex].AddXY(k, param, str, Color) else
                       FchChart.Series[ViewIndex].AddXY(k, param, DateToStr(m_pGrData.Items[i].m_sdtDate), Color)
      else
        if j <> 0 then FchChart.Series[ViewIndex].AddXY(k, param, '', Color) else
        if j = 0 then FchChart.Series[ViewIndex].AddXY(k, param, DateToStr(m_pGrData.Items[i].m_sdtDate), Color);

     end;
    end;
    lbT1Min.Caption := DVLS(min[0]); lbT1Max.Caption := DVLS(max[0]); lbT1Sum.Caption := DVLS(sum[0]);
    lbT2Min.Caption := DVLS(min[1]); lbT2Max.Caption := DVLS(max[1]); lbT2Sum.Caption := DVLS(sum[1]);
    lbT3Min.Caption := DVLS(min[2]); lbT3Max.Caption := DVLS(max[2]); lbT3Sum.Caption := DVLS(sum[2]);
    lbT4Min.Caption := DVLS(min[3]); lbT4Max.Caption := DVLS(max[3]); lbT4Sum.Caption := DVLS(sum[3]);
    lbTSSum.Caption := DVLS(sum[0]+sum[1]+sum[2])+' '+m_pMetaTbl.m_sEMet;
    lbT1Min.Font.Color := DarkColors[0]; lbT1Max.Font.Color := DarkColors[0]; lbT1Sum.Font.Color := DarkColors[0];
    lbT2Min.Font.Color := DarkColors[1]; lbT2Max.Font.Color := DarkColors[1]; lbT2Sum.Font.Color := DarkColors[1];
    lbT3Min.Font.Color := DarkColors[2]; lbT3Max.Font.Color := DarkColors[2]; lbT3Sum.Font.Color := DarkColors[2];
    lbT4Min.Font.Color := DarkColors[3]; lbT4Max.Font.Color := DarkColors[3]; lbT4Sum.Font.Color := DarkColors[3];
    if (FMasterIndex=nAVMid)and(FIndex=nAParam) then
    ViewTableSlice(m_pGrData);
end;
procedure TGraphFrame.PaintGraphSliceKIKU();
var i, j, k ,b    : integer;
    Index       : Integer;
    str         : string;
    Color       : TColor;
    IsInst      : array [0..3] of boolean;
    min, max    : array [0..3] of Double;
    sum         : array [0..3] of Double;
    param       : Double;
    Meters      : SL2TAGREPORTLIST;
    KIKU        : Extended;
begin
    FchChart.Series[0].Clear;
    KIKU      := 0;
    DrawLabels;
    for i := 0 to 3 do begin IsInst[i] := false; sum[i] := 0; end;
    k := FIndex - QRY_SRES_ENR_EP + 1;
    //if m_blPower=True  then m_pDB.GetTMTarPeriodsTable(FMasterIndex, FTID+4, m_pTariffs);
    //if m_blPower=False then m_pDB.GetTMTarPeriodsTable(FMasterIndex, FTID, m_pTariffs);
    //if m_blPower=True  then m_pDB.GetTMTarPeriodsCmdTable(FMasterIndex,FIndex,m_pTariffs);
    //if m_blPower=False then m_pDB.GetRealTMTarPeriodsPlaneTable(FMasterIndex,FIndex,m_pTariffs);

    k := 0;
    if  m_pDB.GetKI_KU(nAVMid, Meters) then
    begin
     for b := 0 to Meters.Count-1 do
         KIKU := Meters.m_sMeter[b].m_sfKI*Meters.m_sMeter[b].m_sfKU;
    end;
    {$IFDEF MINSK_ENERGO_DEBUG}
    if m_pGrData.Count = 1 then
      FchChart.BottomAxis.LabelsSeparation := 10
    else
      FchChart.BottomAxis.LabelsSeparation := 0;
    {$ENDIF}
    for i:=0 to m_pGrData.Count-1 do
    begin
     if m_blPower=True  then m_pDB.GetTMTarPeriodsCmdTable(m_pGrData.Items[i].m_sdtDate,FMasterIndex,FIndex,4,m_pTariffs);
     if m_blPower=False then m_pDB.GetTMTarPeriodsCmdTable(m_pGrData.Items[i].m_sdtDate,FMasterIndex,FIndex,0,m_pTariffs);//m_pDB.GetRealTMTarPeriodsPlaneTable(m_pGrData.Items[i].m_sdtDate,FMasterIndex,FIndex,4,m_pTariffs);
     for j:=0 to 47 do
     begin
      param := m_pGrData.Items[i].v[j]/KIKU;

      if (j mod 2=0)and(advRadioGroup.ItemIndex=1) then param := (m_pGrData.Items[i].v[j]+m_pGrData.Items[i].v[j+1])/KIKU;
      if (j mod 2=1)and(advRadioGroup.ItemIndex=1) then continue;
      if (m_blPower=True)and(advRadioGroup.ItemIndex=0) then param := 2*param;

      //if m_blPower=True then param := 2*param;
      Index := GetColorFromTariffs(j, m_pTariffs) - 1;
      sum[Index] := sum[Index] +  param;
      if not IsInst[Index] then
      begin
       min[Index] := param;
       max[Index] := param;
       IsInst[Index] := true;
      end;
      if param < min[Index] then min[Index] := param;
      if param > max[Index] then max[Index] := param;
      if advRadioGroup.ItemIndex=0 then
      begin
        str := IntToStr((j + 1) div 2) + ':';
        if (j + 1) mod 2 = 0 then str := str + '00' else str := str + '30'
      end
      else
      begin
        str := IntToStr((j + 2) div 2) + ':';
        if (j + 2) mod 2 = 0 then str := str + '00' else str := str + '30'
      end;
      Inc(k);
      //if (FMTID = MET_SUMM) or (FMTID = MET_GSUMM) then
        Color := GetColorForSlice(Index, j, m_pGrData.Items[i].m_sMaskReRead, m_pGrData.Items[i].m_sdtDate);
      //else
      //  Color := GetColorForSlice(Index, j, m_pGrData.Items[i].m_sMaskRead, m_pGrData.Items[i].m_sdtDate);
      if m_pGrData.Count = 1 then
        if j <> 0 then FchChart.Series[ViewIndex].AddXY(k, param, str, Color) else
                       FchChart.Series[ViewIndex].AddXY(k, param, DateToStr(m_pGrData.Items[i].m_sdtDate), Color)
      else
          if j <> 0 then FchChart.Series[ViewIndex].AddXY(k, param, '', Color) else
          FchChart.Series[ViewIndex].AddXY(k, param, DateToStr(m_pGrData.Items[i].m_sdtDate), Color);
     end;
    end;
    lbT1Min.Caption := DVLS(min[0]); lbT1Max.Caption := DVLS(max[0]); lbT1Sum.Caption := DVLS(sum[0]);
    lbT2Min.Caption := DVLS(min[1]); lbT2Max.Caption := DVLS(max[1]); lbT2Sum.Caption := DVLS(sum[1]);
    lbT3Min.Caption := DVLS(min[2]); lbT3Max.Caption := DVLS(max[2]); lbT3Sum.Caption := DVLS(sum[2]);
    lbT4Min.Caption := DVLS(min[3]); lbT4Max.Caption := DVLS(max[3]); lbT4Sum.Caption := DVLS(sum[3]);
    lbTSSum.Caption := DVLS(sum[0]+sum[1]+sum[2])+' '+m_pMetaTbl.m_sEMet;
    lbT1Min.Font.Color := DarkColors[0]; lbT1Max.Font.Color := DarkColors[0]; lbT1Sum.Font.Color := DarkColors[0];
    lbT2Min.Font.Color := DarkColors[1]; lbT2Max.Font.Color := DarkColors[1]; lbT2Sum.Font.Color := DarkColors[1];
    lbT3Min.Font.Color := DarkColors[2]; lbT3Max.Font.Color := DarkColors[2]; lbT3Sum.Font.Color := DarkColors[2];
    lbT4Min.Font.Color := DarkColors[3]; lbT4Max.Font.Color := DarkColors[3]; lbT4Sum.Font.Color := DarkColors[3];
    if (FMasterIndex=nAVMid)and(FIndex=nAParam) then
    ViewTableSliceKIKU(m_pGrData);
end;

procedure TGraphFrame.PaintGraphArch();
Var
     str           : String;
     i, i_exp, iH  : Integer;
     min, max, sum : single;
     param         : single;
     res           : Boolean;
     Color         : TColor;
Begin
     //b_KiKu := False;
     i_exp := 5;   // число столбцов с тарифами
     if FSVStatus=SV_PDPH_ST then
     begin
      if FIndex = QRY_U_PARAM_S then
        res := PrepVoltSumData(m_pData)
      else if FIndex = QRY_I_PARAM_S then
        res := PrepCurrSummData(m_pData)
      else if ((FIndex >= QRY_U_PARAM_A)and(FIndex<=QRY_U_PARAM_C)) then
       begin
        res := m_pDB.GetCurrentData(FMasterIndex,FIndex,m_pData_CUR);
       //function CDBase.GetCurrentData(FIndex,FCmdIndex:Integer;var pTable:L3CURRENTDATAS):Boolean;
        if res=False then begin ClearTableArch(); Exit; end;
        for i:=0 to m_pData_CUR.Count-1 do
        Begin
         param := m_pData_CUR.Items[i].m_sfValue;
         iH:=(i*(i_exp-1))+i;
           FchChart.Series[ViewIndex].AddXY(iH,param,str,clBlue);                  // или здесь.
        end;
        exit;        
       end
      else if ((FIndex >= QRY_I_PARAM_A)and(FIndex<=QRY_I_PARAM_C)) then
       begin
        res := m_pDB.GetCurrentData(FMasterIndex,FIndex,m_pData_CUR);
       //function CDBase.GetCurrentData(FIndex,FCmdIndex:Integer;var pTable:L3CURRENTDATAS):Boolean;
        if res=False then begin ClearTableArch(); Exit; end;
        for i:=0 to m_pData_CUR.Count-1 do
        Begin
         param := m_pData_CUR.Items[i].m_sfValue;
         iH:=(i*(i_exp-1))+i;
           FchChart.Series[ViewIndex].AddXY(iH,param,str,clBlue);                  // или здесь.
        end;
        exit;
       end

      else
        res := m_pDB.GetGDPData(dtPic1.DateTime,dtPic2.DateTime,FMasterIndex,FIndex,m_pData);
     end;
     if FSVStatus=SV_ARCH_ST then res := m_pDB.GetGData(dtPic1.DateTime,dtPic2.DateTime,FMasterIndex,FIndex,cbTariff.ItemIndex,m_pData);           // breakpoint
     if res=False then begin ClearTableArch(); Exit; end;

     sum := 0;
     min := m_pData.Items[0].m_sfValue;
     max := m_pData.Items[0].m_sfValue;
     if cbTariff.ItemIndex <> 0 then  ControlCRC(m_pData);
     for i:=0 to m_pData.Count-1 do
     Begin
      if FSVStatus=SV_ARCH_ST then
        str   := DateToStr(m_pData.Items[i].m_sTime)
      else
      Begin
        if ((i mod 48)=0) then
        str := DateToStr(m_pData.Items[i].m_sTime) else
        str := TimeToStr(m_pData.Items[i].m_sTime+EncodeTime(0,30,0,0));
      End;
      param := m_pData.Items[i].m_sfValue;
      if param < min then min := param;
      if param > max then max := param;
      sum := sum + param;
      try
       begin
         if (m_pData.Items[i].m_sbyMaskReRead = 0) and ((FMTID = MET_SUMM) or (FMTID = MET_GSUMM)) and
            (FSVStatus=SV_ARCH_ST) then
      //if ((m_pData.Items[i].m_sbyMaskReRead = 0) and ((FMTID = MET_SUMM) or (FMTID = MET_GSUMM)) and
      //   (FSVStatus=SV_ARCH_ST))or((m_pData.Items[i].m_sbyMaskRead=0) and (FSVStatus=SV_ARCH_ST)) then
         begin
           if lbValidData.Font.Color <> clRed then
           begin
             lbValidData.Caption    := 'Данные не достоверны';
             lbValidData.Font.Color := clRed;
           end;
           FchChart.Series[ViewIndex].AddXY(i,param,str,ChangeColor(clBlue, 210));   // JKLJKL и вот здесь он его и рисует.
         end
         else
         begin
           if (lbValidData.Font.Color = clBlack + 1) then
           begin
             lbValidData.Caption    := 'Данные достоверны';
             lbValidData.Font.Color := clBlack;
           end;                                             // BO 25/10/18 далее доработка отрисовки графика до следующего end;
           iH:=(i*(i_exp-1))+i;
           FchChart.Series[ViewIndex].AddXY(iH,param,str+' Тариф 0 (суммарный)',clBlue);                  // или здесь.
           iH:=(i*(i_exp-1))+i+1;
           FchChart.Series[ViewIndex].AddXY(iH,m_pData.Items[i].m_sfValue1,str+' Тариф 1',clGreen);       // m_pData.Items[i].m_sfValue
           iH:=(i*(i_exp-1))+i+2;
           FchChart.Series[ViewIndex].AddXY(iH,m_pData.Items[i].m_sfValue2,str+' Тариф 2',clOlive);
           iH:=(i*(i_exp-1))+i+3;
           FchChart.Series[ViewIndex].AddXY(iH,m_pData.Items[i].m_sfValue3,str+' Тариф 3',clTeal);
           iH:=(i*(i_exp-1))+i+4;
           FchChart.Series[ViewIndex].AddXY(iH,m_pData.Items[i].m_sfValue4,str+' Тариф 4',clPurple);
         end;
       end;
      except
//       TraceER('(__)CERMD::>Error In TGraphFrame.PaintGraphArch!!!');
      end;
     End;

     if (FMasterIndex=nAVMid)and(FIndex=nAParam) then  ViewTableArch(m_pData);
     lbT1Min.Caption := DVLS(min);
     lbT1Max.Caption := DVLS(max);
     lbT1Sum.Caption := DVLS(sum);
end;
procedure TGraphFrame.PaintGraphArchKIKU();
Var
     str           : String;
     i,b           : Integer;
     min, max, sum : single;
     param         : single;
     res           : Boolean;
     Meters      : SL2TAGREPORTLIST;
     KIKU        : Extended;
Begin
     if FSVStatus=SV_PDPH_ST then res := m_pDB.GetGDPData(dtPic1.DateTime,dtPic2.DateTime,FMasterIndex,FIndex,m_pData);
     if FSVStatus=SV_ARCH_ST then res := m_pDB.GetGData(dtPic1.DateTime,dtPic2.DateTime,FMasterIndex,FIndex,cbTariff.ItemIndex,m_pData);
     if res=False then begin ClearTableArch(); Exit; end;
     KIKU      := 0;
     sum := 0;
     min := m_pData.Items[0].m_sfValue;
     max := m_pData.Items[0].m_sfValue;
     if cbTariff.ItemIndex <> 0 then  ControlCRC(m_pData);
     if  m_pDB.GetKI_KU(nAVMid, Meters) then
     begin
     for b := 0 to Meters.Count-1 do
         KIKU := Meters.m_sMeter[b].m_sfKI*Meters.m_sMeter[b].m_sfKU;
     end;
     for i:=0 to m_pData.Count-1 do
     Begin
     if FSVStatus=SV_ARCH_ST then
        str   := DateToStr(m_pData.Items[i].m_sTime)
      else
      Begin
        if (i mod 48)=0 then
        str := DateToStr(m_pData.Items[i].m_sTime) else
        str := TimeToStr(m_pData.Items[i].m_sTime);
      End;
        str   := DateTimeToStr(m_pData.Items[i].m_sTime);
      //str   := DateToStr(m_pData.Items[i].m_sTime);
      param := m_pData.Items[i].m_sfValue/KIKU;;
      if param < min then min := param;
      if param > max then max := param;
      sum := sum + param;
      try
       if (param>1700) and (i=0) then  FchChart.Series[ViewIndex].AddXY(-1, 0, '0', clBlue) else
       begin
         if (m_pData.Items[i].m_sbyMaskReRead = 0) and ((FMTID = MET_SUMM) or (FMTID = MET_GSUMM)) then
         //if ((m_pData.Items[i].m_sbyMaskReRead = 0) and ((FMTID = MET_SUMM) or (FMTID = MET_GSUMM)) and
         //(FSVStatus=SV_ARCH_ST))or((m_pData.Items[i].m_sbyMaskRead=0) and (FSVStatus=SV_ARCH_ST)) then
         begin
           if lbValidData.Font.Color <> clRed then
           begin
             lbValidData.Caption := 'Данные не достоверны';
             lbValidData.Font.Color   := clRed;
           end;
           FchChart.Series[ViewIndex].AddXY(i,param,str,ChangeColor(clBlue, 210));
         end
         else
         begin
           if (lbValidData.Color = clBlack + 1) then
           begin
             lbValidData.Caption := 'Данные достоверны';
             lbValidData.Font.Color   := clBlack;
           end;
           FchChart.Series[ViewIndex].AddXY(i,param,str,clBlue);
         end;
       end;
      except
//       TraceER('(__)CERMD::>Error In TGraphFrame.PaintGraphArch!!!');
      end;
     End;
     if (FMasterIndex=nAVMid)and(FIndex=nAParam) then  ViewTableArchKIKU(m_pData);
     lbT1Min.Caption := DVLS(min);
     lbT1Max.Caption := DVLS(max);
     lbT1Sum.Caption := DVLS(sum);
end;
function TGraphFrame.ReturnCRC(m_sfValue:array of double):word;
begin
 result := CalcCRCDB(@m_sfValue,length(m_sfValue)*sizeof(double));
end;

procedure TGraphFrame.ControlCRC(pTab:CCDatasWithTarif);
var
  bl_CRC_modify : boolean;
  CRC_Read,i,j      : Integer;
begin
  bl_CRC_modify := false;
  for i := 0 to pTab.Count-1 do
  begin
    CRC_Read := ReturnCRC(pTab.Items[i].m_sfValue);
     if  ((pTab.Items[i].m_CRC <> -1) and (CRC_Read <> pTab.Items[i].m_CRC)) then
     begin
      bl_CRC_modify := true;
       break;
     end;
end;
 if (bl_CRC_modify)  then
 begin
 //m_pDB.FixUspdEvent(0,0,EVH_MOD_DATA); //EVENT
 end;
end;

procedure TGraphFrame.ControlCRC(pTab:L3GRAPHDATAS);
var
  bl_CRC_modify : boolean;
  CRC_Read,i,j      : Integer;
begin
  bl_CRC_modify := false;
  for i := 0 to pTab.Count-1 do
  begin
  CRC_Read:=0;
  for j := 0 to 47 do
  begin
     CRC_Read := CRC_Read + ReturnCRC(pTab.Items[i].v[j]);
  end;
   if ((pTab.Items[i].m_CRC <> -1) and  (CRC_Read <> pTab.Items[i].m_CRC)) then
     begin
      bl_CRC_modify := true;
     end;
  end;
 if (bl_CRC_modify) then
 begin
  //m_pDB.FixUspdEvent(0,0,EVH_MOD_DATA); //EVENT
 end;
end;


procedure TGraphFrame.ViewData;
Var
     i : Integer;
Begin
     lbValidData.Caption := 'ООО "Автоматизация 2000"';
     lbValidData.Font.Color   := clBlack + 1;                        // breakpoint
     dtPic1.DateTime := m_dtTime1;
     dtPic2.DateTime := m_dtTime2;
     OnResizeGraph(Owner);
     m_pDB.GetGMetaData(FIndex,m_pMetaTbl);                                // breakpoint
     ReplaceIsPower;                                                   // breakpoint
     if PPage.ActivePageIndex = 0 then PPage.ActivePageIndex := 2;
     FchChart.Series[ViewIndex].Clear;
     FchChart.Series[ViewIndex].Title := ' ';
     DrawLabels;                                                        // breakpoint
     m_blInFocus := False;
     m_nValIndex := 0;
     case FSVStatus of
     SV_GRPH_ST:
     begin
      {$IFDEF MINSK_ENERGO_DEBUG}
      if FSVStatus=SV_GRPH_ST then  //alex_2012 22.09.11
      Begin
       if trunc(dtPic1.DateTime - dtPic2.DateTime) >= 31 then
       Begin
        m_dtTime1  := m_dtTime2 + 31;
        dtPic1.DateTime := m_dtTime1;
       End;
      End;
     {$ENDIF}
      InitSlice;
      if m_pDB.GetGraphDatas(dtPic1.DateTime, dtPic2.DateTime, FMasterIndex, FIndex, m_pGrData) then
      begin
        ControlCRC(m_pGrData);
        if b_KiKu=False then PaintGraphSlice()else PaintGraphSliceKIKU();
     end;
     end;
     SV_ARCH_ST:
     begin
      InitArch;
      if b_KiKu=False then PaintGraphArch()else PaintGraphArchKIKU();
     // PaintGraphArch;
     end;
     SV_PDPH_ST:
     Begin
      InitPeriodic;
      if b_KiKu=False then PaintGraphArch()else PaintGraphArchKIKU();
      //PaintGraphArch;
     End;
     end;

End;
procedure TGraphFrame.ViewSlice;
Begin
     if m_pDB.GetGraphDatas(dtPic1.DateTime, dtPic2.DateTime, FMasterIndex, FIndex, m_pGrData) then
     begin
     if  b_KiKu = true then  ViewTableSliceKIKU(m_pGrData) else
     ViewTableSlice(m_pGrData);
     end;
End;
procedure TGraphFrame.ViewArchive;
Begin
     if  b_KiKu = true then ViewTableArchKIKU(m_pData) else                         // breakpoint
     ViewTableArch(m_pData);
End;
{
FsgPGrid.Cells[0,0]  := '№/T';
     FsgPGrid.Cells[1,0]  := 'Дата';
     FsgPGrid.Cells[2,0]  := 'Время';
     FsgPGrid.Cells[3,0]  := 'Параметр';
     FsgPGrid.Cells[4,0]  := 'Сокращение';
     FsgPGrid.Cells[5,0]  := 'Значение';
     FsgPGrid.Cells[6,0]  := 'Единица измерения';
}

procedure TGraphFrame.ViewTableSlice(var Tbl:L3GRAPHDATAS);
var nY, Slice, k,i,j : Integer;
    nVisible     : Integer;
    str          : string[10];
    strL         : string;
    param        : Single;
    BadColor     : TColor;
begin
   FsgPGrid.Cells[5,0] := 'Значение';
   BadColor := ChangeColor(clRed, 80);
   k := 1;
   FsgPGrid.RowCount := (Tbl.Count)*48 + 1{50};
   FsgPGrid.ClearNormalCells;
   for nY := 0 to Tbl.Count - 1 do
     for Slice := 0 to 47 do
     begin
      i := nY;
      j := Slice;
      param := Tbl.Items[nY].v[Slice];
      //if m_blPower=True then param := 2*param;
      if (j mod 2=0)and(advRadioGroup.ItemIndex=1) then param := Tbl.Items[i].v[j]+Tbl.Items[i].v[j+1];
      if (j mod 2=1)and(advRadioGroup.ItemIndex=1) then continue;
      if (m_blPower=True)and(advRadioGroup.ItemIndex=0) then
      begin
        FsgPGrid.Cells[5,0] := 'Значение';
        param := 2*param;
      end else
        FsgPGrid.Cells[5,0] := 'Значение';


      FsgPGrid.Cells[0,k] := IntToStr(k);
      FsgPGrid.Cells[1,k] := DateToStr(Tbl.Items[nY].m_sdtDate);
      if advRadioGroup.ItemIndex=0 then
      begin
        str := IntToStr((j + 1) div 2) + ':';
        if (j + 1) mod 2 = 0 then str := str + '00' else str := str + '30'
      end
      else
      begin
        str := IntToStr((j + 2) div 2) + ':';
        if (j + 2) mod 2 = 0 then str := str + '00' else str := str + '30'
      end;
      FsgPGrid.Cells[2,k] := str;
      FsgPGrid.Cells[3,k] := m_pMetaTbl.m_sName;

      FsgPGrid.Cells[4,k] := m_pMetaTbl.m_sShName;



      FsgPGrid.Cells[5,k] := DVLS5(param);



      FsgPGrid.Cells[6,k] := m_pMetaTbl.m_sEMet;
      if IsBitInMask(Tbl.Items[nY].m_sMaskReRead, Slice) then
        FsgPGrid.Cells[7,k] := 'Достоверен'
      else
      begin
        FsgPGrid.Colors[7,k] := BadColor;              //Light Red
        FsgPGrid.Cells[7,k] := 'Не достоверен';
      end;

      Inc(k);
     end;
     if PPage.ActivePageIndex=1 then ViewTableSliceE;
end;
procedure TGraphFrame.ViewTableArch(var pTbl:CCDatasWithTarif);
Var
     Date, Time       : String;
     i, nY            : Integer;
     pDT              : PCData;
     LastDate         : TDateTime;
     param            : double;
     BadColor     : TColor;
begin
   //  FsgPGrid.Cells[5,0] := 'Значение';                         // BO 23/10/18
     BadColor := ChangeColor(clRed, 80);
     nY := 1;
     FsgPGrid.ClearNormalCells;
     FsgPGrid.RowCount := m_pData.Count + 1 {50};
     m_pDB.GetPrecision(FMasterIndex,MeterPrecision[FMasterIndex]);
     for i:=0 to m_pData.Count-1 do
     Begin
      pDT      := @m_pData.Items[i];
      Date     := DateToStr(pDT.m_sTime);
      Time     := TimeToStr(pDT.m_sTime);
      param := m_pData.Items[i].m_sfValue;                   // JKLJKL
      FsgPGrid.Cells[0,nY] := IntToStr(nY);
      FsgPGrid.Cells[1,nY] := Date;
      FsgPGrid.Cells[2,nY] := Time;
      FsgPGrid.Cells[3,nY] := m_pMetaTbl.m_sName;

//      FsgPGrid.Cells[4,nY] := m_pMetaTbl.m_sShName;            // BO 23/10/18
      //FsgPGrid.Cells[5,nY] := FloatToStrF(param,ffFixed,10,6);
//       FsgPGrid.Cells[5,nY] := FloatToStr(RVLPr(param, MeterPrecision[FMasterIndex]));   // BO 23/10/18

      FsgPGrid.Cells[4,nY] := FloatToStrF(m_pData.Items[i].m_sfValue,ffFixed,10,2);     // BO 23/10/18
      FsgPGrid.Cells[5,nY] := FloatToStrF(m_pData.Items[i].m_sfValue1,ffFixed,10,2);    // BO 23/10/18
      FsgPGrid.Cells[6,nY] := FloatToStrF(m_pData.Items[i].m_sfValue2,ffFixed,10,2);    // BO 23/10/18
      FsgPGrid.Cells[7,nY] := FloatToStrF(m_pData.Items[i].m_sfValue3,ffFixed,10,2);    // BO 23/10/18
      FsgPGrid.Cells[8,nY] := FloatToStrF(m_pData.Items[i].m_sfValue4,ffFixed,10,2);    // BO 23/10/18

//      FsgPGrid.Cells[6,nY] := m_pMetaTbl.m_sEMet;                                     // BO 23/10/18

      FsgPGrid.Cells[9,nY] := m_pMetaTbl.m_sEMet;                                     // BO 23/10/18

      //if ((m_pData.Items[i].m_sbyMaskReRead = 0) and ((FMTID = MET_SUMM) or (FMTID = MET_GSUMM)) and
      //   (FSVStatus=SV_ARCH_ST))or((m_pData.Items[i].m_sbyMaskRead=0) and (FSVStatus=SV_ARCH_ST)) then
      if ((m_pData.Items[i].m_sbyMaskReRead = 0) and ((FMTID = MET_SUMM) or (FMTID = MET_GSUMM)) and
         (FSVStatus=SV_ARCH_ST)) then
      begin
//        FsgPGrid.Cells[7,nY] := 'Не достоверен';                    // BO 23/10/18
//        FsgPGrid.Colors[7,nY] := BadColor;  //Light Red             // BO 23/10/18
        FsgPGrid.Cells[10,nY] := 'Не достоверен';                    // BO 23/10/18
        FsgPGrid.Colors[10,nY] := BadColor;  //Light Red             // BO 23/10/18
      end
      else
//        FsgPGrid.Cells[7,nY] := 'Достоверен';            // BO 23/10/18
        FsgPGrid.Cells[10,nY] := 'Достоверен';            // BO 23/10/18
      Inc(nY);
     End;
     if (FMasterIndex=nAVMid)and(FIndex=nAParam) then
     if PPage.ActivePageIndex=1 then ViewTableArchE;
End;

procedure TGraphFrame.ClearTableArch();
var i: integer;
begin
    FsgPGrid.ClearNormalCells;
    FsgEGrid.ClearNormalCells;
end;

procedure TGraphFrame.ViewTableArchKIKU(var pTbl:CCDatasWithTarif);
Var
     Date, Time       : String;
     i, nY,b          : Integer;
     pDT              : PCData;
     LastDate         : TDateTime;
     param            : double;
     Meters           : SL2TAGREPORTLIST;
     KIKU             : Extended;
     BadColor         : TColor;
begin
     FsgPGrid.Cells[5,0] := 'Значение';
     BadColor := ChangeColor(clRed, 80);
     nY := 1;
     FsgPGrid.ClearNormalCells;
     FsgPGrid.RowCount := m_pData.Count + 1 {50};
      /////ki*ku//////
    if  m_pDB.GetKI_KU(nAVMid, Meters) then
    begin
      for i := 0 to Meters.Count - 1 do
         KIKU := Meters.m_sMeter[i].m_sfKI*Meters.m_sMeter[i].m_sfKU;
     end;
   ///////////////////
     for i:=0 to m_pData.Count-1 do
     Begin
      pDT      := @m_pData.Items[i];
      Date     := DateToStr(pDT.m_sTime);
      Time     := TimeToStr(pDT.m_sTime);
      param := m_pData.Items[i].m_sfValue/KIKU;
      FsgPGrid.Cells[0,nY] := IntToStr(nY);
      FsgPGrid.Cells[1,nY] := Date;
      FsgPGrid.Cells[2,nY] := Time;
      FsgPGrid.Cells[3,nY] := m_pMetaTbl.m_sName;
      FsgPGrid.Cells[4,nY] := m_pMetaTbl.m_sShName;
      //FsgPGrid.Cells[5,nY] := FloatToStrF(param,ffFixed,10,6);
      FsgPGrid.Cells[5,nY] := DVLS(param);
      FsgPGrid.Cells[6,nY] := m_pMetaTbl.m_sEMet;
      if (m_pData.Items[i].m_sbyMaskReRead = 0) and ((FMTID = MET_SUMM) or (FMTID = MET_GSUMM)) and
         (FSVStatus=SV_ARCH_ST) then
      //if ((m_pData.Items[i].m_sbyMaskReRead = 0) and ((FMTID = MET_SUMM) or (FMTID = MET_GSUMM)) and
      //   (FSVStatus=SV_ARCH_ST))or((m_pData.Items[i].m_sbyMaskRead=0) and (FSVStatus=SV_ARCH_ST)) then
      begin
        FsgPGrid.Cells[7,nY] := 'Не достоверен';
        FsgPGrid.Colors[7,nY] := BadColor;  //Light Red
      end
      else
        FsgPGrid.Cells[7,nY] := 'Достоверен';
      Inc(nY);
     End;
     if (FMasterIndex=nAVMid)and(FIndex=nAParam) then
     if PPage.ActivePageIndex=1 then ViewTableArchE;
End;
{
function CMeter.saveToDB(var pMsg:CHMessage):Boolean;
Var
     data : L3CURRENTDATA;
     dDT  : CDTTime;
Begin
     data.m_swVMID  := pMsg.m_swObjID;
     data.m_swCMDID := pMsg.m_sbyInfo[1];
     data.m_swTID   := pMsg.m_sbyInfo[8];
     data.m_swSID   := pMsg.m_sbyServerID;
     Move(pMsg.m_sbyInfo[2],dDT,sizeof(CDTTime));
     if (dDT.Year=0)or(dDT.Month=0)or(dDT.Day=0)or(dDT.Month>12)or(dDT.Hour>23)or(dDT.Month>12)or(dDT.Day>31)or(dDT.Sec>59) then exit else
     data.m_sTime   := EncodeDate(2000+dDT.Year,dDT.Month,dDT.Day)+EncodeTime(dDT.Hour,dDT.Min,dDT.Sec,0);
     Move(pMsg.m_sbyInfo[9],data.m_sfValue,sizeof(Double));
     case getTypeParam(data.m_swCMDID) of
          SV_CURR_ST:
          Begin
            dynConnect.SetCurrentParamNoBlock(data);
            if not ((data.m_swCMDID>=QRY_ENERGY_SUM_EP) and (data.m_swCMDID<=QRY_ENERGY_SUM_EP)) then
            dynConnect.UpdatePDTFilds_48(data);
          End;
          SV_ARCH_ST:
          Begin
           //if isTrueValue(data) then
           dynConnect.AddArchDataNoBlock(data);
          End;
          SV_GRPH_ST: dynConnect.UpdateGD48(data);
     End;
End;

}
procedure TGraphFrame.saveRow(rowIndex:Integer);
Var
     data : L3CURRENTDATA;
     dDT  : CDTTime;
     tar  : Integer;
Begin
     if ((rowIndex<>-1) and (cbTariff.ItemIndex>0)) then
     Begin
      tar            := cbTariff.ItemIndex-1;
      data.m_swVMID  := PMID;
      data.m_swCMDID := PIndex;
      data.m_swTID   := tar;
      data.m_sfValue := StrToFloat(FsgPGrid.Cells[5,rowIndex]);
      data.m_sTime   := StrToDate(FsgPGrid.Cells[1,rowIndex]);
      data.m_sbyMaskRead := 1;
      if MessageDlg('Выполнить сохранение:'+
      ' Параметр: '+ GetCMD(data.m_swCMDID)+
      ' Тариф: '+IntToStr(data.m_swTID)+
      ' Значение: '+FsgPGrid.Cells[5,rowIndex]+
      ' Время: '+FsgPGrid.Cells[1,rowIndex]+' ?',mtWarning,[mbOk,mbCancel],0)=mrOk then
      Begin
       m_pDB.AddArchDataNoBlock(data);
      End;
     End;
End;
procedure TGraphFrame.saveRowAllTariff(rowIndex:Integer);
Var
     data : L3CURRENTDATA;
     dDT  : CDTTime;
     tar,i  : Integer;
Begin
     if (rowIndex<>-1) then
     Begin
      for i:=0 to 4 do
       begin
         tar            := i;//cbTariff.ItemIndex-1;
         data.m_swVMID  := PMID;
         data.m_swCMDID := PIndex;
         data.m_swTID   := i;
         data.m_sfValue := StrToFloat(FsgPGrid.Cells[4+i,rowIndex]);
         data.m_sTime   := StrToDate(FsgPGrid.Cells[1,rowIndex]);
         data.m_sbyMaskRead := 1;
       {    if MessageDlg('Выполнить сохранение:'+
           ' Параметр: '+ GetCMD(data.m_swCMDID)+
           ' Тариф: '+IntToStr(data.m_swTID)+
           ' Значение: '+FsgPGrid.Cells[5,rowIndex]+
           ' Время: '+FsgPGrid.Cells[1,rowIndex]+' ?',mtWarning,[mbOk,mbCancel],0)=mrOk then     }
          Begin
           m_pDB.AddArchDataNoBlock(data);
          End;  
       end;
     End

    else
      if MessageDlg('Введите хотя бы одну запись',mtInformation,[mbOk],0)=mrOk then
      exit;
End;

procedure TGraphFrame.createRow(rowIndex:Integer);
Var
     nextIndex : Integer;
Begin
     if (FsgPGrid.RowCount>=rowIndex) then
     Begin
      FsgPGrid.RowCount := FsgPGrid.RowCount + 1;
      if(rowIndex=-1) then
       nextIndex := FindFreeRow(FsgPGrid,1)
       else
       nextIndex := rowIndex;
    {  FsgPGrid.Cells[0,nextIndex] := IntToStr(nextIndex);
      FsgPGrid.Cells[1,nextIndex] := DateToStr(Now);
      FsgPGrid.Cells[2,nextIndex] := TimeToStr(Now);
      FsgPGrid.Cells[3,nextIndex] := GetCMD(PIndex);
      FsgPGrid.Cells[4,nextIndex] := '';
      FsgPGrid.Cells[5,nextIndex] := '0.0';
      FsgPGrid.Cells[6,nextIndex] := '';
      FsgPGrid.Cells[7,nextIndex] := 'Достоверен';}
      FsgPGrid.Cells[0,nextIndex] := IntToStr(nextIndex);
      FsgPGrid.Cells[1,nextIndex] := DateToStr(Now);
      FsgPGrid.Cells[2,nextIndex] := TimeToStr(Now);
      FsgPGrid.Cells[3,nextIndex] := GetCMD(PIndex);
      FsgPGrid.Cells[4,nextIndex] := '0.0';
      FsgPGrid.Cells[5,nextIndex] := '0.0';
      FsgPGrid.Cells[6,nextIndex] := '0.0';
      FsgPGrid.Cells[7,nextIndex] := '0.0';
      FsgPGrid.Cells[8,nextIndex] := '0.0';
      FsgPGrid.Cells[9,nextIndex] := '';
      FsgPGrid.Cells[10,nextIndex] := 'Достоверен';

     End;
End;
function TGraphFrame.FindFreeRow(pGrid:PTAdvStringGrid;nIndex:Integer):Integer;
Var
    i : Integer;
Begin
    for i:=1 to pGrid.RowCount-1 do
    if pGrid.Cells[nIndex,i]='' then
    Begin
     Result := i;
     exit;
    End;
    Result := 1;
End;
procedure TGraphFrame.cloneRow(rowIndex:Integer);
Var
     nextIndex : Integer;
Begin
     if ((rowIndex<>-1) and (FsgPGrid.RowCount>=rowIndex)) then
     Begin
      FsgPGrid.RowCount := FsgPGrid.RowCount + 1;
      //nextIndex := FsgPGrid.RowCount-1;
      nextIndex := FindFreeRow(FsgPGrid,1);
      FsgPGrid.Cells[0,nextIndex] := FsgPGrid.Cells[0,rowIndex];
      FsgPGrid.Cells[1,nextIndex] := FsgPGrid.Cells[1,rowIndex];
      FsgPGrid.Cells[2,nextIndex] := FsgPGrid.Cells[2,rowIndex];
      FsgPGrid.Cells[3,nextIndex] := FsgPGrid.Cells[3,rowIndex];
      FsgPGrid.Cells[4,nextIndex] := FsgPGrid.Cells[4,rowIndex];
      FsgPGrid.Cells[5,nextIndex] := FsgPGrid.Cells[5,rowIndex];
      FsgPGrid.Cells[6,nextIndex] := FsgPGrid.Cells[6,rowIndex];
      FsgPGrid.Cells[7,nextIndex] := FsgPGrid.Cells[7,rowIndex];
     End;
End;

procedure TGraphFrame.ViewTableSliceE();
var nY, Slice, k,j     : Integer;
    i, KindEn        : Integer;
    FBInd            : Integer;
    nVisible         : Integer;
    str              : string[10];
    strL             : string;
    param            : double;
    BadColor         : TColor;
begin
   FsgPGrid.Cells[5,0] := 'Значение';
   BadColor := ChangeColor(clRed, 80);
   FBInd := FIndex - (FIndex - 1) mod 4;
   FsgEGrid.ClearNormalCells;
   for KindEn := 0 to 3 do
   begin
     if not m_pDB.GetGraphDatas(dtPic1.DateTime, dtPic2.DateTime, FMasterIndex, FBInd + KindEn, m_pGrData) then exit;
     k := 1;
     FsgEGrid.RowCount := (m_pGrData.Count)*48 + 1;
     for nY := 0 to m_pGrData.Count - 1 do
      for Slice := 0 to 47 do
      begin
       param := m_pGrData.Items[nY].v[Slice];

       i := nY;
       j := Slice;
       if (j mod 2=0)and(advRadioGroup.ItemIndex=1) then param := m_pGrData.Items[i].v[j]+m_pGrData.Items[i].v[j+1];
       if (j mod 2=1)and(advRadioGroup.ItemIndex=1) then continue;
       if (m_blPower=True)and(advRadioGroup.ItemIndex=0) then param := 2*param;

       //if m_blPower=True then param := 2*param;
       FsgEGrid.Cells[0,k] := IntToStr(k);
       FsgEGrid.Cells[1,k] := DateToStr(m_pGrData.Items[nY].m_sdtDate);
       if advRadioGroup.ItemIndex=0 then
       begin
         str := IntToStr((j + 1) div 2) + ':';
         if (j + 1) mod 2 = 0 then str := str + '00' else str := str + '30'
       end
       else
       begin
         str := IntToStr((j + 2) div 2) + ':';
         if (j + 2) mod 2 = 0 then str := str + '00' else str := str + '30'
       end;
       strL := m_pMetaTbl.m_sEMet;
       if m_blPower=True  then FsgEGrid.Cells[3,k] := 'P+,P-,Q+,Q-' else
       if m_blPower=False then FsgEGrid.Cells[3,k] := 'Wp+,Wp-,Wq+,Wq-';
       FsgEGrid.Cells[8,k] := m_pMetaTbl.m_sEMet;;
       FsgEGrid.Cells[2,k] := str;
       FsgEGrid.Cells[4+KindEn,k] := DVLS5(param);
       if IsBitInMask(m_pGrData.Items[nY].m_sMaskReRead, Slice) then
        FsgEGrid.Cells[9,k] := 'Достоверен'
       else
       begin
        FsgEGrid.Cells[9,k] := 'Не достоверен';
        FsgEGrid.Colors[9,k] := BadColor; //Light Red
       end;
       Inc(k);
       end;
   end;
end;

procedure TGraphFrame.ViewTableArchE();
Var
     Date, Time       : String;
     i, KindEn, nY    : Integer;
     FBInd            : Integer;
     pDT              : PCData;
     LastDate         : TDateTime;
     param            : double;
     BadColor         : TColor;
begin
      FsgPGrid.Cells[5,0] := 'Значение';
      BadColor := ChangeColor(clRed, 80);
      FsgEGrid.RowCount := m_pData.Count + 1;
      FBInd := FIndex - (FIndex - 1) mod 4;
      for KindEn :=0 to 3 do
      begin
      //m_pDB.GetGData(dtPic1.DateTime,dtPic2.DateTime,FMasterIndex,FIndex,cbTariff.ItemIndex,m_pData)
        if not m_pDB.GetGData(dtPic1.DateTime,dtPic2.DateTime,FMasterIndex,FBInd + KindEn,cbTariff.ItemIndex, m_pData) then
          continue;
        i := 0; nY := 1;
        while (i < m_pData.Count) do
        Begin
          pDT      := @m_pData.Items[i];
          Date     := DateToStr(pDT.m_sTime);
          Time     := TimeToStr(pDt.m_sTime);
          param    := 0;
          LastDate := pDt.m_sTime;
          while LastDate = m_pData.Items[i].m_sTime do
          begin
            if (m_pData.Items[i].m_swTID = 0) or (i>=m_pData.Count) then
            begin
             param := m_pData.Items[i].m_sfValue;
             Inc(i);
             continue;
            end else if (i > 0) and (m_pData.Items[i - 1].m_swTID = 0) then
              param := 0;
            param := param + m_pData.Items[i].m_sfValue;
            Inc(i);
          end;
          FsgEGrid.Cells[0,nY]          := IntToStr(nY);
          FsgEGrid.Cells[1,nY]          := Date;
          FsgEGrid.Cells[2,nY]          := Time;
          FsgEGrid.Cells[3,nY]          := m_pMetaTbl.m_sName;
          FsgEGrid.Cells[4 + KindEn,nY] := DVLS(param);
          FsgEGrid.Cells[8,nY]          := m_pMetaTbl.m_sEMet;
          if (m_pData.Items[i].m_sbyMaskReRead = 0) and ((FMTID = MET_SUMM) or (FMTID = MET_GSUMM)) and
             (FSVStatus=SV_ARCH_ST) then
          //if ((m_pData.Items[i].m_sbyMaskReRead = 0) and ((FMTID = MET_SUMM) or (FMTID = MET_GSUMM)) and
          //(FSVStatus=SV_ARCH_ST))or((m_pData.Items[i].m_sbyMaskRead=0) and (FSVStatus=SV_ARCH_ST)) then
          begin
            FsgEGrid.Cells[9,nY] := 'Не достоверен';
            FsgEGrid.Colors[9,nY] := BadColor; //Light Red
          end
          else
            FsgEGrid.Cells[9,nY] := 'Достоверен';
          Inc(nY);
        End;
     end;
     m_pDB.GetGData(dtPic1.DateTime,dtPic2.DateTime,FMasterIndex,FIndex,cbTariff.ItemIndex, m_pData)
end;

procedure TGraphFrame.ViewTableSliceKIKU(var Tbl:L3GRAPHDATAS);
var nY, Slice, k,i,j : Integer;
    nVisible     : Integer;
    str          : string[10];
    strL         : string;
    param        : double;
    Meters       : SL2TAGREPORTLIST;
    KIKU         : Extended;
    BadColor         : TColor;
begin
   FsgPGrid.Cells[5,0] := 'Значение';
   BadColor := ChangeColor(clRed, 80);
   KIKU := 0;
   k    := 1;
   FsgPGrid.RowCount := (Tbl.Count)*48 + 1;// + 50;
   FsgPGrid.ClearNormalCells;
    /////ki*ku//////
   if  m_pDB.GetKI_KU(nAVMid, Meters) then
   begin
     for i := 0 to Meters.Count - 1 do
         KIKU := Meters.m_sMeter[i].m_sfKI*Meters.m_sMeter[i].m_sfKU;
    end;
   ///////////////////
     for nY := 0 to Tbl.Count - 1 do
     begin
     for Slice := 0 to 47 do
     begin
      param := Tbl.Items[nY].v[Slice]/KIKU;
      i := nY;j := Slice;
      if (j mod 2=0)and(advRadioGroup.ItemIndex=1) then param := (m_pGrData.Items[i].v[j]+m_pGrData.Items[i].v[j+1])/KIKU;
      if (j mod 2=1)and(advRadioGroup.ItemIndex=1) then continue;
      if (m_blPower=True)and(advRadioGroup.ItemIndex=0) then
      begin
        FsgPGrid.Cells[5,0] := 'Мощность';
        param := 2*param;
      end else
        FsgPGrid.Cells[5,0] := 'Энергия';
      //if m_blPower=True then param := 2*param;
      FsgPGrid.Cells[0,k] := IntToStr(k);
      FsgPGrid.Cells[1,k] := DateToStr(Tbl.Items[nY].m_sdtDate);
      if advRadioGroup.ItemIndex=0 then
      begin
        str := IntToStr((j + 1) div 2) + ':';
        if (j + 1) mod 2 = 0 then str := str + '00' else str := str + '30'
      end
      else
      begin
        str := IntToStr((j + 2) div 2) + ':';
        if (j + 2) mod 2 = 0 then str := str + '00' else str := str + '30'
      end;
      FsgPGrid.Cells[2,k] := str;
      FsgPGrid.Cells[3,k] := m_pMetaTbl.m_sName;
      FsgPGrid.Cells[4,k] := m_pMetaTbl.m_sShName;
      FsgPGrid.Cells[5,k] := DVLS5(param);//FloatToStr(param);//DVLS(param);
      FsgPGrid.Cells[6,k] := m_pMetaTbl.m_sEMet;
      if IsBitInMask(Tbl.Items[nY].m_sMaskReRead, Slice) then
        FsgPGrid.Cells[7,k] := 'Достоверен'
       else
       begin
        FsgPGrid.Cells[7,k] := 'Не достоверен';
        FsgPGrid.Colors[7,k] := BadColor; //Light Red
       end;
      Inc(k);
     end;
    end;
    if PPage.ActivePageIndex=1 then ViewTableSliceKIKUE;
end;
procedure TGraphFrame.ViewTableSliceKIKUE();
var nY, Slice, k,j     : Integer;
    i, KindEn          : Integer;
    FBInd              : Integer;
    nVisible           : Integer;
    str                : string[10];
    strL               : string;
    param              : double;
    Meters             : SL2TAGREPORTLIST;
    KIKU               : Extended;
    BadColor           : TColor;
begin
   FsgPGrid.Cells[5,0] := 'Значение';
   BadColor := ChangeColor(clRed, 80);
   FBInd := FIndex - (FIndex - 1) mod 4;
   FsgEGrid.ClearNormalCells;
   if  m_pDB.GetKI_KU(nAVMid, Meters) then
   begin
    for i := 0 to Meters.Count - 1 do KIKU := Meters.m_sMeter[i].m_sfKI*Meters.m_sMeter[i].m_sfKU;
   end;
   for KindEn := 0 to 3 do
   begin
     if not m_pDB.GetGraphDatas(dtPic1.DateTime, dtPic2.DateTime, FMasterIndex, FBInd + KindEn, m_pGrData) then exit;
     k := 1;
     FsgEGrid.RowCount := (m_pGrData.Count)*48 + 1;
     for nY := 0 to m_pGrData.Count - 1 do
      for Slice := 0 to 47 do
      begin

       param := m_pGrData.Items[nY].v[Slice]/KIKU;
       i := nY;
       j := Slice;
       if (j mod 2=0)and(advRadioGroup.ItemIndex=1) then param := (m_pGrData.Items[i].v[j]+m_pGrData.Items[i].v[j+1])/KIKU;
       if (j mod 2=1)and(advRadioGroup.ItemIndex=1) then continue;
       if (m_blPower=True)and(advRadioGroup.ItemIndex=0) then param := 2*param;

       //if m_blPower=True then param := 2*param;
       FsgEGrid.Cells[0,k] := IntToStr(k);
       FsgEGrid.Cells[1,k] := DateToStr(m_pGrData.Items[nY].m_sdtDate);
       str := IntToStr(Slice div 2) + ':';
       if Slice mod 2 = 0 then str := str + '00' else str := str + '30';
       strL := m_pMetaTbl.m_sEMet;
       if m_blPower=True  then FsgEGrid.Cells[3,k] := 'P+,P-,Q+,Q-' else
       if m_blPower=False then FsgEGrid.Cells[3,k] := 'Wp+,Wp-,Wq+,Wq-';
       FsgEGrid.Cells[8,k] := m_pMetaTbl.m_sEMet;;
       if IsBitInMask(m_pGrData.Items[nY].m_sMaskReRead, Slice) then
        FsgEGrid.Cells[9,k] := 'Достоверен'
       else
       begin
        FsgPGrid.Colors[9,k] := BadColor; //Light Red
        FsgEGrid.Cells[9,k] := 'Не достоверен';
       end;
       FsgEGrid.Cells[2,k] := str;
       FsgEGrid.Cells[4+KindEn,k] := DVLS5(param);
       Inc(k);
       end;
   end;
end;

procedure TGraphFrame.OnUpdateData(Sender: TObject);
Var
     pDS : CMessageData;
begin
     if PPage.ActivePageIndex = 0 then PPage.ActivePageIndex := 2;
     nAVMid   := FMasterIndex;
     nAParam  := FIndex;
     pDS.m_swData0 := FMasterIndex;
     pDS.m_swData1 := FIndex;
     SendMsgData(BOX_L3,FIndex,DIR_L4TOL3,AL_UPDATEGRAPH_REQ,pDS);
end;
procedure TGraphFrame.OnLoadCounter(Sender: TObject);
Var
     szDT : Integer;
     pDS  : CMessageData;
begin
     if IsGraph=True then
     Begin
      szDT := sizeof(TDateTime);
      pDS.m_swData0 := FMasterIndex;
      pDS.m_swData1 := FIndex;
      pDS.m_swData2 := FMID;
      pDS.m_swData3 := FPRID;
      pDS.m_swData4 := FLocation;
      Move(dtPic2.DateTime,pDS.m_sbyInfo[0]   ,szDT);
      Move(dtPic1.DateTime,pDS.m_sbyInfo[szDT],szDT);
      SendMsgData(BOX_L3_LME,FMasterIndex,DIR_LHTOLM3,LME_STOP_POLL_REQ,pDS);
      SendMsgData(BOX_L3_LME,FMID,DIR_LHTOLM3,QL_DATA_GRAPH_REQ,pDS);
      //SendMsgData(BOX_L2,FMID,DIR_L3TOL2,QL_DATA_GRAPH_REQ,pDS);
      //SendMsgData(BOX_L3_LME,FMasterIndex,DIR_LHTOLM3,LME_GO_GRAPH_POLL_REQ,pDS);
     End;
end;
procedure TGraphFrame.OnStopQuery(Sender: TObject);
Var
    pDS : CMessageData;
begin
    if MessageDlg('Остановить опрос графиков?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
//     m_pDB.FixUspdDescEvent(0,3,EVS_STOP_TRAN,FIndex);
     SendQSData(QS_STOP_SR,-1,PIndex,dtPic1.DateTime,dtPic2.DateTime);
    End;
end;
procedure TGraphFrame.SendRemCrcQry(nPort:Byte;var pDS:CMessageData);
Var
    m_nTxMsg : CHMessage;
    fnc,wCRC:Word;
Begin
    FPRID := 0;
    FillChar(m_nTxMsg.m_sbyInfo[0],80,0);
    move(pDS.m_swData0,m_nTxMsg.m_sbyInfo[6], 4);
    move(pDS.m_swData1,m_nTxMsg.m_sbyInfo[10],4);
    move(pDS.m_swData2,m_nTxMsg.m_sbyInfo[14],4);
    move(pDS.m_swData3,m_nTxMsg.m_sbyInfo[18],4);
    move(pDS.m_sbyInfo[0],m_nTxMsg.m_sbyInfo[26],sizeof(TDateTime)*2);
    if m_blIsRemCrc=True then
    Begin
     CreateMsgCrcRem(m_nTxMsg.m_sbyInfo[0], (26+16+1)+4, $FF02);
     CreateMSGHeadCrcRem(FPRID,m_nTxMsg, (26+16+1)+4);
    End else
    if m_blIsRemEco=True then
    Begin
     m_nTxMsg.m_sbyInfo[0] := 1;
     m_nTxMsg.m_sbyInfo[1] := 202;
     wCRC := CRCEco(m_nTxMsg.m_sbyInfo[0], 26+16);
     m_nTxMsg.m_sbyInfo[26+16] := Lo(wCRC);
     m_nTxMsg.m_sbyInfo[26+16+1] := Hi(wCRC);
     CreateMSGHeadCrcRem(FPRID,m_nTxMsg, (26+16+2));
    End;
    if m_blIsRemC12 then
    Begin
     m_nTxMsg.m_sbyInfo[0] := 1;
     m_nTxMsg.m_sbyInfo[1] := $FA;
     m_nTxMsg.m_sbyInfo[2] := 202;
     CRC_C12(m_nTxMsg.m_sbyInfo[0], 26+16+2);
     CreateMSGHeadCrcRem(FPRID,m_nTxMsg, (26+16+2));
    End;
    {
    if not CRCRem(m_nTxMsg.m_sbyInfo[0], m_nTxMsg.m_sbyInfo[3] - 2) then
    begin
      //TraceM(4,pMsg.m_swObjID,'(__)CL4MD::>BTI CRC ERROR!!!:',@pMsg);
      exit;
    end;
    fnc    := m_nTxMsg.m_sbyInfo[4]*$100 + m_nTxMsg.m_sbyInfo[5];
    }
//    TraceM(2,m_nTxMsg.m_sbyIntID,'(__)CCRRM::>Out DRQ:',@m_nTxMsg);
    FPUT(BOX_L1, @m_nTxMsg);
End;
procedure TGraphFrame.SendDelCrcQry(nPort:Byte;var pDS:CMessageData);
Var
    m_nTxMsg : CHMessage;
    fnc,wCRC:Word;
Begin
    FPRID := 0;
    FillChar(m_nTxMsg.m_sbyInfo[0],80,0);
    move(pDS.m_swData0,m_nTxMsg.m_sbyInfo[6], 4);
    move(pDS.m_swData1,m_nTxMsg.m_sbyInfo[10],4);
    move(pDS.m_swData2,m_nTxMsg.m_sbyInfo[14],4);
    move(pDS.m_swData3,m_nTxMsg.m_sbyInfo[18],4);
    move(pDS.m_sbyInfo[0],m_nTxMsg.m_sbyInfo[26],sizeof(TDateTime)*2);
    if m_blIsRemCrc=True then
    Begin
     CreateMsgCrcRem(m_nTxMsg.m_sbyInfo[0], (26+16+1)+4, $FF19);
     CreateMSGHeadCrcRem(FPRID,m_nTxMsg, (26+16+1)+4);
    End else
    if m_blIsRemEco=True then
    Begin
     m_nTxMsg.m_sbyInfo[0] := 1;
     m_nTxMsg.m_sbyInfo[1] := 214;
     wCRC := CRCEco(m_nTxMsg.m_sbyInfo[0], 26+16);
     m_nTxMsg.m_sbyInfo[26+16] := Lo(wCRC);
     m_nTxMsg.m_sbyInfo[26+16+1] := Hi(wCRC);
     CreateMSGHeadCrcRem(FPRID,m_nTxMsg, (26+16+2));
    End;
    if m_blIsRemC12 then
    Begin
     m_nTxMsg.m_sbyInfo[0] := 1;
     m_nTxMsg.m_sbyInfo[1] := $FA;
     m_nTxMsg.m_sbyInfo[2] := 214;
     CRC_C12(m_nTxMsg.m_sbyInfo[0], 26+16+2);
     CreateMSGHeadCrcRem(FPRID,m_nTxMsg, (26+16+2));
    End;
    {
    if not CRCRem(m_nTxMsg.m_sbyInfo[0], m_nTxMsg.m_sbyInfo[3] - 2) then
    begin
      //TraceM(4,pMsg.m_swObjID,'(__)CL4MD::>BTI CRC ERROR!!!:',@pMsg);
      exit;
    end;
    fnc    := m_nTxMsg.m_sbyInfo[4]*$100 + m_nTxMsg.m_sbyInfo[5];
    }
//    TraceM(2,m_nTxMsg.m_sbyIntID,'(__)CCRRM::>Out DRQ:',@m_nTxMsg);
    FPUT(BOX_L1, @m_nTxMsg);
End;
{
procedure CBTIModule.FNCReadGraphFromMeters(var pMsg : CMessage);
Var
   szDT : Integer;
   pDS  : CMessageData;
begin
   move(pMsg.m_sbyInfo[6], pDS.m_swData0, 4);
   move(pMsg.m_sbyInfo[10], pDS.m_swData1, 4);
   move(pMsg.m_sbyInfo[14], pDS.m_swData2, 4);
   move(pMsg.m_sbyInfo[18], pDS.m_swData3, 4);
   if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
   if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
   move(pMsg.m_sbyInfo[26], pDS.m_sbyInfo[0], sizeof(TDateTime)*2);
   SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL_REQ,pDS);
   SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_DATA_ALLGRAPH_REQ,pDS);
end;
}
function TGraphFrame.IsGraph:Boolean;
Var
     res : Boolean;
Begin
     res := False;
     case FIndex of
      QRY_ENERGY_DAY_EP,  QRY_ENERGY_MON_EP,
      QRY_SRES_ENR_EP,    QRY_SRES_ENR_EM,
      QRY_SRES_ENR_RP,    QRY_SRES_ENR_RM,
      QRY_NAK_EN_DAY_EP,
      QRY_NAK_EN_MONTH_EP,QRY_MAX_POWER_EP,
      QRY_NACKM_POD_TRYB_HEAT,
      QRY_NACKM_POD_TRYB_RASX,
      QRY_NACKM_POD_TRYB_TEMP,
      QRY_NACKM_POD_TRYB_V,
      QRY_NACKM_OBR_TRYB_HEAT,
      QRY_NACKM_OBR_TRYB_RASX,
      QRY_NACKM_OBR_TRYB_TEMP,
      QRY_NACKM_OBR_TRYB_V,
      QRY_NACKM_TEMP_COLD_WAT_DAY,
      QRY_NACKM_POD_TRYB_RUN_TIME,
      QRY_NACKM_WORK_TIME_ERR ,

      QRY_POD_TRYB_HEAT,
      QRY_POD_TRYB_RASX,
      QRY_POD_TRYB_TEMP,
      QRY_POD_TRYB_V,
      QRY_OBR_TRYB_HEAT,
      QRY_OBR_TRYB_RASX,
      QRY_OBR_TRYB_TEMP,
      QRY_OBR_TRYB_V,
      QRY_TEMP_COLD_WAT_DAY,
      QRY_POD_TRYB_RUN_TIME,
      QRY_RASH_HOR_V,
      QRY_RASH_DAY_V,
      QRY_RASH_MON_V,
      QRY_WORK_TIME_ERR :
      res := True;
     End;
     Result := res;
End;

procedure TGraphFrame.dtPic1Change(Sender: TObject);
begin
     dtPic2.DateTime := dtPic1.DateTime;
     nAParam     := FIndex;
     nAVMid      := FMasterIndex;
     nActSVStat  := FSVStatus;
     m_dtTime1   := dtPic1.DateTime;
     m_dtTime2   := m_dtTime1;
     ViewData;
     //OnUpdateData(Sender);
end;

procedure TGraphFrame.OnDelete(Sender: TObject);
var DataGraph   : L3GRAPHDATA;
    DataCurrent : L3CURRENTDATA;
    DataBrestEnergo  : VAL;
    pDS : CMessageData;
    dtDate : TDateTime;
begin
{   if (not m_pDB.IsCoverOpen)or(m_byCoverState=0) then
   begin
     MessageDlg('Крышка УСПД закрыта. Данные не могут быть удалены!', mtWarning,[mbOk, mbCancel],0);
     exit;
   end; }
   if m_nUM.CheckPermitt(SA_USER_PERMIT_PRE,True,m_blNoCheckPass) then
   Begin
//   m_pDB.FixUspdDescEvent(0,3,EVS_DEL_AR_PER,FIndex);
   DataGraph.m_swVMID    := FMasterIndex;
   DataGraph.m_swCMDID   := FIndex;
   DataGraph.m_swID      := FABOID; //ABOID
   DataCurrent.m_swVMID  := FMasterIndex;
   DataCurrent.m_swCMDID := FIndex;
   DataCurrent.m_swTID   := FABOID; //ABOID

   DataBrestEnergo.n_obj := FMasterIndex;
   DataBrestEnergo.izm_type := FIndex;
   if  (FIndex >=13) and (FIndex <= 16)  then  DataBrestEnergo.izm_type := FIndex- QRY_SRES_ENR_EP + 1;
   if  (FIndex >= 17) and (FIndex <= 20) then  DataBrestEnergo.izm_type := FIndex- QRY_NAK_EN_DAY_EP + 5 ;
   if (m_blIsRemCrc=True)or(m_blIsRemEco=True)or(m_blIsRemC12=True) then
   Begin
    pDS.m_swData0 := FSVStatus;
    pDS.m_swData1 := FPHAddres;
    pDS.m_swData2 := FIndex;
    dtDate:=dtPic2.DateTime; Move(dtDate,pDS.m_sbyInfo[0],sizeof(TDateTime));
    dtDate:=dtPic1.DateTime; Move(dtDate,pDS.m_sbyInfo[sizeof(TDateTime)],sizeof(TDateTime));
    SendDelCrcQry(FPRID,pDS);
    exit;
   End;
   if MessageDlg('Удалить график за период?',mtWarning,[mbOk,mbCancel],0)=mrOk then
   case FSVStatus of
     SV_GRPH_ST : begin
                  m_pDB.DelGraphData(dtPic2.DateTime, dtPic1.DateTime, DataGraph);
                  //m_pDB.DelArchEnergoData(dtPic2.DateTime, dtPic1.DateTime, DataBrestEnergo);
//                  m_pDB.FixUspdEvent(0,0,EVH_DEL_BASE); //EVENT
                  end;
     SV_ARCH_ST : begin
                  m_pDB.DelArchData(dtPic2.DateTime, dtPic1.DateTime, DataCurrent);
                  //m_pDB.DelArchEnergoData(dtPic2.DateTime, dtPic1.DateTime, DataBrestEnergo);
//                  m_pDB.FixUspdEvent(0,0,EVH_DEL_BASE); //EVENT
                  end;
     SV_PDPH_ST : m_pDB.DelPdtData(dtPic2.DateTime, dtPic1.DateTime, DataCurrent);
   end;
  ViewData;
  End;

end;

procedure TGraphFrame.OnPic2Chandge(Sender: TObject);
begin
    m_dtTime2 := dtPic2.DateTime;
    if dtPic2.DateTime <= dtPic1.DateTime then
    begin
     {$IFDEF MINSK_ENERGO_DEBUG}
     if FSVStatus=SV_GRPH_ST then  //alex_2012 22.09.11
     Begin
      if trunc(dtPic1.DateTime - dtPic2.DateTime) >= 31 then
      m_dtTime1  := m_dtTime2 + 31;
     End;
     {$ENDIF}
     OnUpdateData(Sender);
    end
    else
    Begin
     dtPic1.DateTime := dtPic2.DateTime;
     m_dtTime1       := m_dtTime2;
    End;
end;

procedure TGraphFrame.OutTextOnPrinter(x, y : single;var str : string;var PrinterI:TPrinter);
var xText, yText : Integer;
Width            : Integer;
begin
   xText := trunc(PrinterI.PageWidth  * x);
   yText := trunc(PrinterI.PageHeight * y);
   Width := trunc(PrinterI.Canvas.TextWidth(str)/2);
   PrinterI.Canvas.TextOut(xText - Width, yText, str);
end;

procedure TGraphFrame.OnPrintSlice(Sender: TObject);
var Rect, RectText      : TRect;
    PrinterI            : TPrinter;
    FinishCol           : integer;
    str, strChart       : string;
    x, y, Width         : integer;
begin

   PrinterI             := Printer;
   strChart             := FchChart.Series[ViewIndex].Title;
   PrinterI.Orientation := poLandscape;
   PrinterI.Canvas.Font.Name :=  'Times New Roman';
   PrinterI.Canvas.Font.Size := 15;
   PrinterI.Canvas.Font.Style :=[fsItalic,fsBold];

   PrinterI.BeginDoc;

   //str := FchChart.Series[0].Title;
   //str := Caption;

   //OutTextOnPrinter(0.5, 0.04, str, PrinterI);

   //str := 'Динамика потребления';
   //OutTextOnPrinter(0.5, 0.08, str, PrinterI);

   PrinterI.Canvas.Font.Size := 10;
   if m_blPower=False then Begin
   str := 'Min T1: ' + lbT1Min.Caption + '; Max T1: ' + lbT1Max.Caption + '; Sum T1: ' + lbT1Sum.Caption;
   OutTextOnPrinter(0.5, 0.9, str, PrinterI);

   str := 'Min T2: ' + lbT2Min.Caption + '; Max T2: ' + lbT2Max.Caption + '; Sum T2: ' + lbT2Sum.Caption;
   OutTextOnPrinter(0.5, 0.92, str, PrinterI);

   str := 'Min T3: ' + lbT3Min.Caption + '; Max T3: ' + lbT3Max.Caption + '; Sum T3: ' + lbT3Sum.Caption;
   OutTextOnPrinter(0.5, 0.94, str, PrinterI);

   str := 'Min T4: ' + lbT4Min.Caption + '; Max T4: ' + lbT4Max.Caption + '; Sum T4: ' + lbT4Sum.Caption;
   OutTextOnPrinter(0.5, 0.96, str, PrinterI);
   End else
   if m_blPower=True then
   Begin
   str := 'Min T1: ' + lbT1Min.Caption + '; Max T1: ' + lbT1Max.Caption;
   OutTextOnPrinter(0.5, 0.9, str, PrinterI);

   str := 'Min T2: ' + lbT2Min.Caption + '; Max T2: ' + lbT2Max.Caption;
   OutTextOnPrinter(0.5, 0.92, str, PrinterI);

   str := 'Min T3: ' + lbT3Min.Caption + '; Max T3: ' + lbT3Max.Caption;
   OutTextOnPrinter(0.5, 0.94, str, PrinterI);

   str := 'Min T4: ' + lbT4Min.Caption + '; Max T4: ' + lbT4Max.Caption;
   OutTextOnPrinter(0.5, 0.96, str, PrinterI);
   End;

   str := 'Время: ' + DateTimeToStr(Now);
   PrinterI.Canvas.Font.Size := 10;
   PrinterI.Canvas.Font.Style :=[fsItalic];
   OutTextOnPrinter(0.9, 0.96, str, PrinterI);

   str := 'Automation 2k'#174;
   OutTextOnPrinter(0.1, 0.96, str, PrinterI);

   FchChart.Series[ViewIndex].Title := '  ';
   //FchChart.Refresh;
   Rect.Top   := trunc(PrinterI.PageHeight * 0.15);
   Rect.Left  := trunc(PrinterI.PageWidth  * 0.05);
   Rect.Bottom:= trunc(PrinterI.PageHeight * 0.85);
   Rect.Right := trunc(PrinterI.PageWidth  * 0.95);
   FchChart.PrintPartialCanvas(PrinterI.Canvas, Rect);

   PrinterI.EndDoc;

   FchChart.Series[ViewIndex].Title := strChart;

   FchChart.Refresh;

   if FActive then
   begin
     FsgPGrid.PrintSettings.HeaderSize  := 200;
     FsgPGrid.PrintSettings.Centered    := true;
     FsgPGrid.PrintSettings.Orientation := poLandscape;
     FsgPGrid.PrintSettings.Borders     := pbSingle;
     FsgPGrid.Print;
   end;

end;

procedure TGraphFrame.OnUpdateArch(Sender: TObject);
begin
    ViewData;
end;
function TGraphFrame.FindRow(pGrid:PTAdvStringGrid;str:String):Integer;
Var
   i : Integer;
Begin
   for i:=1 to pGrid.RowCount-1 do
    if pGrid.Cells[0,i]=str then
      Begin
       if (i-pGrid.VisibleRowCount)>0  then pGrid.TopRow := i-pGrid.VisibleRowCount+1 else pGrid.TopRow := 1;
       Result := i;
       exit;
      End;
    Result := 1;
End;
procedure TGraphFrame.OnDbClickGraph(Sender: TObject);
Var
     pDS : CMessageData;
begin
     nAParam     := FIndex;
     nAVMid      := FMasterIndex;
     nActSVStat  := FSVStatus;
     pDS.m_swData0 := FMasterIndex;
     pDS.m_swData1 := FIndex;
     if FSVStatus = SV_GRPH_ST then
     Begin
      if PPage.ActivePageIndex = 0 then PPage.ActivePageIndex := 2;
      SendMsgData(BOX_L3,FIndex,DIR_L4TOL3,AL_UPDATETSLICE_REQ,pDS);
     End;
     if FSVStatus = SV_ARCH_ST then
     Begin
      PPage.ActivePageIndex := 2;
      SendMsgData(BOX_L3,FIndex,DIR_L4TOL3,AL_UPDATETARCH_REQ,pDS);
     End;
     if FSVStatus = SV_PDPH_ST then
     Begin
      PPage.ActivePageIndex := 2;
      SendMsgData(BOX_L3,FIndex,DIR_L4TOL3,AL_UPDATETARCH_REQ,pDS);
     End;
end;



procedure TGraphFrame.FchChartMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
   if lbShowValue.Visible then
   with MouseM do
   begin
     dX    := dX + abs(LastX - X);
     dY    := dY + abs(LastY - Y);
     LastX := X;
     LastY := Y;
     if (dX + dY > 20) then
       lbShowValue.Visible := false;
   end;
end;

procedure TGraphFrame.FchChartClickSeries(Sender: TCustomChart;
  Series: TChartSeries; ValueIndex: Integer; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var CaptionIndex : integer;            //    BO 20.11.2018
begin
   OnDbClickGraph(Sender);
   FchChart.PopupMenu := advLeftClickMenu;
   CaptionIndex:= ValueIndex;               //    BO 20.11.2018
  if ValueIndex = 0 then
     ValueIndex := 1
   else ValueIndex := ValueIndex div 5;                                // BO 08.11.2018

   lbShowValue.Caption := m_pMetaTbl.m_sShName+'='+DVLS(FchChart.Series[ViewIndex].YValue[CaptionIndex])+' '+m_pMetaTbl.m_sEMet;   //    BO 20.11.2018
   lbShowValue.Visible := true;
   lbShowValue.Top     := Y - 10;
   lbShowValue.Left    := X + 10;
   MouseM.LastX := X;
   MouseM.LastY := Y;
   MouseM.dX    := 0;
   MouseM.dY    := 0;
   m_blInFocus  := True;
   m_nValIndex  := ValueIndex;
   //FindRow(IntToStr(ValueIndex+1));
   if PPage.ActivePageIndex = 2 then
   Begin
    m_nRowIndex := FindRow(FsgPGrid,IntToStr(ValueIndex+1));
    FsgPGrid.SelectRows(m_nRowIndex,1);
    FsgPGrid.Refresh;
   End;
   if PPage.ActivePageIndex = 1 then
   Begin
    m_nRowIndex := FindRow(FsgEGrid,IntToStr(ValueIndex+1));
    FsgEGrid.SelectRows(m_nRowIndex,1);
    FsgEGrid.Refresh;
   End;
end;

procedure TGraphFrame.OnChangeKindGr(Sender: TObject);
begin
   if (Sender as TMenuItem).ImageIndex = 7 then
   begin
     (Sender as TMenuItem).ImageIndex := 8;
     (Sender as TMenuItem).Caption := 'Диаграмма';
     FchChart.Series[0].Clear;
     ViewIndex := 1;
   end
   else
   begin
     (Sender as TMenuItem).ImageIndex := 7;
     (Sender as TMenuItem).Caption := 'Линейный';
     FchChart.Series[1].Clear;
     ViewIndex := 0;
   end;
   ViewData;

end;

 procedure TGraphFrame.OnDellAll(Sender: TObject);
var DataGraph   : L3GRAPHDATA;
    DataCurrent : L3CURRENTDATA;
    DataBrestEnergo  : VAL;
    pDS : CMessageData;
    dtDate: TDateTime;
begin

{   if (not m_pDB.IsCoverOpen)or(m_byCoverState=0) then
   begin
     MessageDlg('Крышка УСПД закрыта. Данные не могут быть удалены!', mtWarning,[mbOk, mbCancel],0);
     exit;
   end; }
   if m_nUM.CheckPermitt(SA_USER_PERMIT_PRE,True,m_blNoCheckPass) then
   Begin
//   m_pDB.FixUspdDescEvent(0,3,EVS_ALL_DEL_AR_PER,FIndex);
   DataGraph.m_swVMID    := FMasterIndex;
   DataGraph.m_swCMDID   := FIndex;
   DataGraph.m_swVMID    := -1;
   DataGraph.m_swID      := FABOID; //ABOID
   DataCurrent.m_swVMID  := -1;
   DataCurrent.m_swCMDID := FIndex;
   DataCurrent.m_swTID   := FABOID;
   DataBrestEnergo.n_obj := -1;
   DataBrestEnergo.izm_type := FIndex;

  if  (FIndex >=13) and (FIndex <= 16) then   DataBrestEnergo.izm_type := FIndex- QRY_SRES_ENR_EP + 1;
  if  (FIndex >= 17) and (FIndex <= 20) then  DataBrestEnergo.izm_type := FIndex- QRY_NAK_EN_DAY_EP + 5 ;
   if MessageDlg('Удалить все графики за период?',mtWarning,[mbOk,mbCancel],0)=mrOk then
   Begin
   if (m_blIsRemCrc=True)or(m_blIsRemEco=True)or(m_blIsRemC12=True) then
   Begin
    pDS.m_swData0 := FSVStatus;
    pDS.m_swData1 := DataGraph.m_swVMID;
    pDS.m_swData2 := FIndex;
    dtDate:=dtPic2.DateTime; Move(dtDate,pDS.m_sbyInfo[0],sizeof(TDateTime));
    dtDate:=dtPic1.DateTime; Move(dtDate,pDS.m_sbyInfo[sizeof(TDateTime)],sizeof(TDateTime));
    SendDelCrcQry(FPRID,pDS);
    exit;
   End;
   case FSVStatus of
     SV_GRPH_ST : begin
                  m_pDB.DelGraphData(dtPic2.DateTime, dtPic1.DateTime, DataGraph);
                  //m_pDB.DelArchEnergoData(dtPic2.DateTime, dtPic1.DateTime, DataBrestEnergo);
//                  m_pDB.FixUspdEvent(0,0,EVH_DEL_BASE); //EVENT
                  end;
     SV_ARCH_ST : begin
                  m_pDB.DelArchData(dtPic2.DateTime, dtPic1.DateTime, DataCurrent);
                  //m_pDB.DelArchEnergoData(dtPic2.DateTime, dtPic1.DateTime, DataBrestEnergo);
//                  m_pDB.FixUspdEvent(0,0,EVH_DEL_BASE); //EVENT
                  end;
     SV_PDPH_ST : m_pDB.DelPdtData(dtPic2.DateTime, dtPic1.DateTime, DataCurrent);
   end;
  ViewData;
  End;
  End;

end;
procedure TGraphFrame.ReplaceIsPower;
Var
    strL : String;
    strS,strC : String;
    nFind : Integer;
Begin
    FchChart.Title.Text.Clear;
 {
 К-во пот.акт.эн.за 30 мин(Wp+)
 К-во выд.акт.эн.за 30 мин(Wp-)
 К-во пот.реа.эн.за 30 мин(Wq+)
 К-во выд.реа.эн.за 30 мин(Wq-)
 }
    if m_blPower=True then
    Begin
     if (FIndex=QRY_SRES_ENR_EP) or (FIndex=QRY_SRES_ENR_EM) or (FIndex=QRY_SRES_ENR_RP) or (FIndex=QRY_SRES_ENR_RM) then
     Delete(m_pMetaTbl.m_sEMet,Length(m_pMetaTbl.m_sEMet)-1, 2);
     strS := Caption;
     nFind := Pos(':',strS);
     Delete(strS,nFind+1,Length(strS)-nFind);
     case FIndex of
      QRY_SRES_ENR_EP:Begin m_pMetaTbl.m_sShName:='P30sp';m_pMetaTbl.m_sName:='Потребляемая.акт.мощность(P+)';End;
      QRY_SRES_ENR_EM:Begin m_pMetaTbl.m_sShName:='P30sm';m_pMetaTbl.m_sName:='Выдаваемая.акт.мощность(P-)';End;
      QRY_SRES_ENR_RP:Begin m_pMetaTbl.m_sShName:='Q30sp';m_pMetaTbl.m_sName:='Потребляемая.реа.мощность(Q+)';End;
      QRY_SRES_ENR_RM:Begin m_pMetaTbl.m_sShName:='Q30sp';m_pMetaTbl.m_sName:='Выдаваемая.реа.мощность(Q-)';End;
     End;
    End else
    if m_blPower=False then
    Begin
     if (FIndex=QRY_SRES_ENR_EP) or (FIndex=QRY_SRES_ENR_EM) or (FIndex=QRY_SRES_ENR_RP) or (FIndex=QRY_SRES_ENR_RM) then
     Delete(m_pMetaTbl.m_sEMet,Length(m_pMetaTbl.m_sEMet)-1, 2);
     strS := Caption;
     nFind := Pos(':',strS);
     Delete(strS,nFind+1,Length(strS)-nFind);
     case FIndex of
      QRY_SRES_ENR_EP:Begin m_pMetaTbl.m_sShName:='P30sp';m_pMetaTbl.m_sName:='К-во пот.акт.эн.за 30 мин(Wp+)';End;
      QRY_SRES_ENR_EM:Begin m_pMetaTbl.m_sShName:='P30sm';m_pMetaTbl.m_sName:='К-во выд.акт.эн.за 30 мин(Wp-)';End;
      QRY_SRES_ENR_RP:Begin m_pMetaTbl.m_sShName:='Q30sp';m_pMetaTbl.m_sName:='К-во пот.реа.эн.за 30 мин(Wq+)';End;
      QRY_SRES_ENR_RM:Begin m_pMetaTbl.m_sShName:='Q30sp';m_pMetaTbl.m_sName:='К-во выд.реа.эн.за 30 мин(Wq-)';End;
     End;
    End;


    if dtPic1.DateTime = dtPic2.DateTime then
    FchChart.Title.Text.Add(strS+m_pMetaTbl.m_sName+':'+m_pMetaTbl.m_sEMet+'(' + DateToStr(dtPic2.DateTime) + ')')
    else
    FchChart.Title.Text.Add(strS+m_pMetaTbl.m_sName+':'+m_pMetaTbl.m_sEMet+'(' + DateToStr(dtPic2.DateTime) +
    ' - ' +  DateToStr(dtPic1.DateTime) + ')');
    Caption := FchChart.Title.Text[0];
    //FchChart.Title.Text.Add(Caption);
End;

procedure TGraphFrame.OnPowerView(Sender: TObject);
begin
   if FSVStatus=SV_GRPH_ST then
   Begin
   if m_blPower=True then
   Begin
    (Sender as TMenuItem).ImageIndex := 11;
    (Sender as TMenuItem).Caption := 'Показывать как мощность';
    if nTariff.Checked=True then Begin
    lbT1Sum.Visible  := False;
    lbT2Sum.Visible  := False;
    lbT3Sum.Visible  := False;
    lbT4Sum.Visible  := False;
    lbSum.Visible    := False;
    lbTSSum.Visible  := False;
    lbGSum.Visible   := False;End;
    m_blPower:=False;
   End else
   if m_blPower=False then
   Begin
    (Sender as TMenuItem).ImageIndex := 10;
    m_blPower:=True;
    (Sender as TMenuItem).Caption := 'Показывать как энергию';
    if nTariff.Checked=True then Begin
    lbT1Sum.Visible  := True;
    lbT2Sum.Visible  := True;
    lbT3Sum.Visible  := True;
    lbT4Sum.Visible  := True;
    lbTSSum.Visible  := True;
    lbGSum.Visible   := True;
    lbSum.Visible    := True;End;
   End;
   ViewData;
   End;
end;

procedure TGraphFrame.OnClearAll(Sender: TObject);
var DataGraph   : L3GRAPHDATA;
    DataCurrent : L3CURRENTDATA;
    DataBrestEnergo  : VAL;
    pDS : CMessageData;
    dtDate : TDateTime;
begin
{   if (not m_pDB.IsCoverOpen)or(m_byCoverState=0) then
   begin
     MessageDlg('Крышка УСПД закрыта. Данные не могут быть удалены!', mtWarning,[mbOk, mbCancel],0);
     exit;
   end;  }
   if m_nUM.CheckPermitt(SA_USER_PERMIT_PRE,True,m_blNoCheckPass) then
   Begin
//   m_pDB.FixUspdDescEvent(0,3,EVS_ALL_DEL_AR,FIndex);
   DataGraph.m_swVMID    := FMasterIndex;
   DataGraph.m_swCMDID   := FIndex;
   DataGraph.m_swVMID    := -2;
   DataGraph.m_swID      := FABOID; //ABOID
   DataCurrent.m_swVMID  := -2;
   DataCurrent.m_swCMDID := FIndex;
   DataCurrent.m_swTID   := FABOID;
   DataBrestEnergo.n_obj := -2;
   DataBrestEnergo.izm_type := FIndex;
   if  (FIndex >=13) and (FIndex <= 16) then   DataBrestEnergo.izm_type := FIndex- QRY_SRES_ENR_EP + 1;
   if  (FIndex >= 17) and (FIndex <= 20) then  DataBrestEnergo.izm_type := FIndex- QRY_NAK_EN_DAY_EP + 5 ;
   if (m_blIsRemCrc=True)or(m_blIsRemEco=True)or(m_blIsRemC12=True) then
   Begin
    pDS.m_swData0 := FSVStatus;
    pDS.m_swData1 := DataGraph.m_swVMID;
    pDS.m_swData2 := FIndex;
    dtDate:=dtPic2.DateTime; Move(dtDate,pDS.m_sbyInfo[0],sizeof(TDateTime));
    dtDate:=dtPic1.DateTime; Move(dtDate,pDS.m_sbyInfo[sizeof(TDateTime)],sizeof(TDateTime));
    SendDelCrcQry(FPRID,pDS);
    exit;
   End;
   if MessageDlg('Удалить все графики?',mtWarning,[mbOk,mbCancel],0)=mrOk then
   case FSVStatus of
      SV_GRPH_ST : begin
                  m_pDB.DelGraphData(dtPic2.DateTime, dtPic1.DateTime, DataGraph);
                  m_pDB.DelArchEnergoData(dtPic2.DateTime, dtPic1.DateTime, DataBrestEnergo);
//                  m_pDB.FixUspdEvent(0,0,EVH_DEL_BASE); //EVENT
                  end;
     SV_ARCH_ST : begin
                  m_pDB.DelArchData(dtPic2.DateTime, dtPic1.DateTime, DataCurrent);
                  m_pDB.DelArchEnergoData(dtPic2.DateTime, dtPic1.DateTime, DataBrestEnergo);
//                  m_pDB.FixUspdEvent(0,0,EVH_DEL_BASE); //EVENT
                  end;
     SV_PDPH_ST : m_pDB.DelPdtData(dtPic2.DateTime, dtPic1.DateTime, DataCurrent);
   end;
  ViewData;
//  m_pDB.FixUspdEvent(0,0,EVH_DEL_BASE); //EVENT
  End;
end;

procedure TGraphFrame.Upd(Sender: TObject);
Var
     i,j,k:Integer;
begin
    //for k:=0 to 3 do
     //Begin
     {
     if m_pDB.GetGraphDatas(dtPic1.DateTime, dtPic2.DateTime, FMasterIndex, FIndex, m_pGrData) then
     Begin
      for i:=0 to m_pGrData.Count-1 do
       Begin
        for j:=0 to 47 do
         Begin
          m_pGrData.Items[i].v[j] := m_pGrData.Items[i].v[j]/2;
         End;
         m_pGrData.Items[i].m_swVMID  := FMasterIndex;
         m_pGrData.Items[i].m_swCMDID := FIndex;
         m_pDB.AddGraphData(m_pGrData.Items[i]);
        End;
     End;
     }
     //End;
end;

procedure TGraphFrame.PaintGraphSliceKIKUClick(Sender: TObject);
begin
   if (Sender as TMenuItem).ImageIndex = 13 then
    begin
     (Sender as TMenuItem).ImageIndex := 8;
     (Sender as TMenuItem).Caption := 'С учетом КТР';
     FchChart.Series[0].Clear;
     ViewIndex := 0;
     b_KiKu := true;
   end
   else
   begin
     (Sender as TMenuItem).ImageIndex := 13;
     (Sender as TMenuItem).Caption := 'Без учета КТР';
     FchChart.Series[0].Clear;
     ViewIndex := 0;
     b_KiKu := False;
   end;
   ViewData;
   //b_KiKu := true;
end;


procedure TGraphFrame.ToolButton2Click(Sender: TObject);
begin

   if (Sender as TMenuItem).ImageIndex = 14 then
   begin
   (Sender as TMenuItem).ImageIndex := 15;
   (Sender as TMenuItem).Caption := 'Выкл. объемность';
   FchChart.View3D:= true
   end
     else
     begin
      (Sender as TMenuItem).ImageIndex := 14;
      (Sender as TMenuItem).Caption := 'Вкл. объемность';
      FchChart.View3D:= False;
     end;

end;

{procedure TGraphFrame.InitProgress;
begin
   ProgressLoad             := TProgressLoad.Create(Application);
   m_ngRCL.OnBreak := true;
   m_ngRCL.PProgress        := @ProgressLoad.AdvProgress1;
   m_ngRCL.PAdvGlassButton  := @ProgressLoad.AdvGlassButton1;
   ProgressLoad.Show;
   ProgressLoad.Refresh;
end;}

procedure TGraphFrame.OnReCalc(Sender: TObject);
Var
     pDS    : CMessageData;
     szDT   : Integer;
     nOutCmd: Integer;
     dtTime1,dtTime2 : TDateTime;
     str    : String;
     nRCL   : DWord;
begin
     szDT := sizeof(TDateTime);
     if m_blIsLocal=True  then Begin pDS.m_swData4 := MTR_LOCAL;str:='Запустить перерасчет графиков c '+DateToStr(dtPic2.DateTime)+' по '+DateToStr(dtPic1.DateTime)+'?' ;End;
     if m_blIsLocal=False then Begin pDS.m_swData4 := MTR_REMOTE;str:='Запустить перерасчет графиков c '+DateToStr(dtPic2.DateTime)+' по '+DateToStr(dtPic1.DateTime)+' удаленно?';End;
     if MessageDlg(str,mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      if m_nUM.CheckPermitt(SA_USER_PERMIT_PRE,True,m_blNoCheckPass) then
      Begin
       szDT := sizeof(TDateTime);
       nRCL := 0;
       if not((FMTID=MET_SUMM)or(FMTID=MET_GSUMM)) then nRCL := RCL_CALCL1;
       if (FMTID=MET_SUMM)  then nRCL := RCL_CALCL2;
       if (FMTID=MET_GSUMM) then nRCL := RCL_CALCL3;
       IsParam4(FIndex,nOutCmd);
       pDS.m_swData0 := nOutCmd;
       pDS.m_swData1 := nRCL;
       pDS.m_swData2 := FMasterIndex;
       pDS.m_swData3 := FABOID;
       dtTime1       := dtPic1.DateTime;
       dtTime2       := dtPic2.DateTime;
       Move(dtTime1,pDS.m_sbyInfo[0]   ,sizeof(TDateTime));
       Move(dtTime2,pDS.m_sbyInfo[szDT],sizeof(TDateTime));
       SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_RCALC_DATA_REQ,pDS);
      End;
     End;
end;
procedure TGraphFrame.OnChangeRadio(Sender: TObject);
begin
    OnUpdateData(self);
end;
{
    if MessageDlg('Запросить события из устройства?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
      nJIM := 0;
      nJIM := (QFH_JUR_EN)or(QFH_JUR_0)or(QFH_JUR_1)or(QFH_JUR_2);
      szDT := sizeof(TDateTime);
      pDS.m_swData0 := FABOID;
      pDS.m_swData1 := FIndex;
      pDS.m_swData2 := FMID;
      pDS.m_swData3 := FPRID;
      if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
      if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
      Move(dtPic2.DateTime,pDS.m_sbyInfo[0]   ,szDT);
      Move(dtPic1.DateTime,pDS.m_sbyInfo[szDT],szDT);
      Move(nJIM,pDS.m_sbyInfo[2*szDT],sizeof(int64));
      if m_blIsRemCrc=True then Begin SendRemCrcQry(FPRID,pDS);exit; End;
      SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_START_FH_REQ,pDS);
    End;
}
function TGraphFrame.GetMaskFromCode(nCMD:Integer;blFind:Boolean;var pDS:CMessageData):int64;
Var
    nJIM : int64;
Begin
    nJIM := 0;
    case nCMD of
         QRY_ENERGY_DAY_EP,QRY_ENERGY_DAY_EM,QRY_ENERGY_DAY_RP,QRY_ENERGY_DAY_RM:nJIM := QFH_ARCH_EN or QFH_ENERGY_DAY_EP;
         QRY_ENERGY_MON_EP,QRY_ENERGY_MON_EM,QRY_ENERGY_MON_RP,QRY_ENERGY_MON_RM:nJIM := QFH_ARCH_EN or QFH_ENERGY_MON_EP;
         QRY_NAK_EN_DAY_EP,QRY_NAK_EN_DAY_EM,QRY_NAK_EN_DAY_RP,QRY_NAK_EN_DAY_RM:nJIM := QFH_ARCH_EN or QFH_NAK_EN_DAY_EP;
         QRY_NAK_EN_MONTH_EP,QRY_NAK_EN_MONTH_EM,QRY_NAK_EN_MONTH_RP,QRY_NAK_EN_MONTH_RM: nJIM := QFH_ARCH_EN or QFH_NAK_EN_MONTH_EP;
         QRY_SRES_ENR_EP,QRY_SRES_ENR_EM,QRY_SRES_ENR_RP,QRY_SRES_ENR_RM:        nJIM := QFH_ARCH_EN or QFH_SRES_ENR_EP;
         QRY_MGAKT_POW_S,QRY_MGAKT_POW_A,QRY_MGAKT_POW_B,QRY_MGAKT_POW_C:        nJIM := QFH_ANET_EN or QFH_ANET_P;
         QRY_MGREA_POW_S,QRY_MGREA_POW_A,QRY_MGREA_POW_B,QRY_MGREA_POW_C:        nJIM := QFH_ANET_EN or QFH_ANET_Q;
         QRY_U_PARAM_S,QRY_U_PARAM_A,QRY_U_PARAM_B,QRY_U_PARAM_C:                nJIM := QFH_ANET_EN or QFH_ANET_U;
         QRY_I_PARAM_S,QRY_I_PARAM_A,QRY_I_PARAM_B,QRY_I_PARAM_C:                nJIM := QFH_ANET_EN or QFH_ANET_I;
         QRY_FREQ_NET:                                                           nJIM := QFH_ANET_EN or QFH_ANET_F;
         QRY_KOEF_POW_A,QRY_KOEF_POW_B,QRY_KOEF_POW_C:                           nJIM := QFH_ANET_EN or QFH_ANET_CFI;
         QRY_NACKM_POD_TRYB_HEAT,QRY_NACKM_POD_TRYB_RASX,QRY_NACKM_POD_TRYB_TEMP,QRY_NACKM_POD_TRYB_V,
         QRY_NACKM_OBR_TRYB_HEAT,QRY_NACKM_OBR_TRYB_RASX,QRY_NACKM_OBR_TRYB_TEMP,QRY_NACKM_OBR_TRYB_V,
         QRY_NACKM_TEMP_COLD_WAT_DAY,QRY_NACKM_POD_TRYB_RUN_TIME,QRY_NACKM_WORK_TIME_ERR :         nJIM := QFH_NACKM_POD_TRYB_HEAT;

         QRY_POD_TRYB_HEAT,QRY_POD_TRYB_RASX,QRY_POD_TRYB_TEMP,QRY_POD_TRYB_V,
         QRY_OBR_TRYB_HEAT,QRY_OBR_TRYB_RASX,QRY_OBR_TRYB_TEMP,QRY_OBR_TRYB_V,
         QRY_TEMP_COLD_WAT_DAY,QRY_POD_TRYB_RUN_TIME,QRY_WORK_TIME_ERR :         nJIM := QFH_POD_TRYB_HEAT;
    End;
    if blFind=True then nJIM := nJIM or QFH_FIND_UPDATE;

    if not((FMTID=MET_SUMM)or(FMTID=MET_GSUMM)) then
    Begin
     nJIM := nJIM or QFH_RECALC_ABOID;
    End else
    if (FMTID=MET_SUMM)or(FMTID=MET_GSUMM) then
    Begin
     nJIM := nJIM or QFH_RECALC_ABOID;
     pDS.m_swData1 := -1; //Если Опрашивается Суммир Сч то ищутся все счетчики и в конце перерасчет
    End;
    Result := nJIM;
End;
function TGraphFrame.IsParam4(nCMDID:Integer;var nOutCmd:Integer):Boolean;
Begin
     Result:=False;
     case nCMDID of
          QRY_ENERGY_DAY_EP,QRY_ENERGY_DAY_EM,QRY_ENERGY_DAY_RP,QRY_ENERGY_DAY_RM:Begin nOutCmd:=QRY_ENERGY_DAY_EP; Result:=True;End;
          QRY_ENERGY_MON_EP,QRY_ENERGY_MON_EM,QRY_ENERGY_MON_RP,QRY_ENERGY_MON_RM:Begin nOutCmd:=QRY_ENERGY_MON_EP; Result:=True;End;
          QRY_NAK_EN_DAY_EP,QRY_NAK_EN_DAY_EM,QRY_NAK_EN_DAY_RP,QRY_NAK_EN_DAY_RM:Begin nOutCmd:=QRY_NAK_EN_DAY_EP; Result:=True;End;
          QRY_NAK_EN_MONTH_EP,QRY_NAK_EN_MONTH_EM,QRY_NAK_EN_MONTH_RP,QRY_NAK_EN_MONTH_RM:Begin nOutCmd:=QRY_NAK_EN_MONTH_EP; Result:=True;End;
          QRY_SRES_ENR_EP,QRY_SRES_ENR_EM,QRY_SRES_ENR_RP,QRY_SRES_ENR_RM        :Begin nOutCmd:=QRY_SRES_ENR_EP;   Result:=True;End;
          QRY_MGAKT_POW_S,QRY_MGAKT_POW_A,QRY_MGAKT_POW_B,QRY_MGAKT_POW_C        :Begin nOutCmd:=QRY_MGAKT_POW_S;   Result:=True;End;
          QRY_MGREA_POW_S,QRY_MGREA_POW_A,QRY_MGREA_POW_B,QRY_MGREA_POW_C        :Begin nOutCmd:=QRY_MGREA_POW_S;   Result:=True;End;
          QRY_U_PARAM_S,QRY_U_PARAM_A,QRY_U_PARAM_B,QRY_U_PARAM_C                :Begin nOutCmd:=QRY_U_PARAM_S;     Result:=True;End;
          QRY_I_PARAM_S,QRY_I_PARAM_A,QRY_I_PARAM_B,QRY_I_PARAM_C                :Begin nOutCmd:=QRY_I_PARAM_S;     Result:=True;End;
     End;
End;
procedure TGraphFrame.StartFind(nCMD:Integer;blFind,blOne:Boolean);
Var
    szDT : Integer;
    pDS  : CMessageData;
    nJIM,nVMID : int64;
Begin
    szDT := sizeof(TDateTime);
    nVMID         := FMasterIndex;
    pDS.m_swData0 := FABOID;
    pDS.m_swData1 := FMasterIndex;
    pDS.m_swData2 := FMID;
    pDS.m_swData3 := FPRID;
    nJIM := GetMaskFromCode(nCMD,blFind,pDS);
    if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
    if m_blIsLocal=False then Begin pDS.m_swData0:=0;pDS.m_swData4:=MTR_REMOTE;End; //На успд ABOID=0
    if blOne=False then pDS.m_swData1 := -1;                                        //Поиск всех VMID в ABOID
    Move(dtPic1.DateTime,pDS.m_sbyInfo[0]   ,szDT);
    Move(dtPic2.DateTime,pDS.m_sbyInfo[szDT],szDT);
    Move(nJIM,pDS.m_sbyInfo[2*szDT],sizeof(int64));
    Move(nVMID,pDS.m_sbyInfo[2*szDT+sizeof(int64)],sizeof(int64));
    if (m_blIsRemCrc=True)or(m_blIsRemEco=True)or(m_blIsRemC12=True) then Begin SendRemCrcQry(FPRID,pDS);exit; End;
    SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_START_FH_REQ,pDS);
End;
{
 property PABOID       : Integer         read FABOID       write FABOID;
    property PIndex       : Integer         read FIndex       write FIndex;
    property PMasterIndex : Integer         read FMasterIndex write FMasterIndex;
    property PMID         : Integer         read FMID         write FMID;
    property PPRID        : Integer         read FPRID        write FPRID;
    property PTID         : Integer         read FTID         write FTID;
    property PSVStatus    : Integer         read FSVStatus    write FSVStatus;
    property PCLStatus    : Integer         read FCLStatus    write FCLStatus;
}
procedure TGraphFrame.OnLoadAllMeter(Sender: TObject);
begin
    if m_nStateLr=0 then Begin MessageDlg('Функция временно не доступна.Ожидайте.',mtWarning,[mbOk,mbCancel],0); exit; End;
    if MessageDlg('Выполнить загрузку параметра '+GetCMD(FIndex)+' из всех счетчиков?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
//     m_pDB.FixUspdDescEvent(0,3,EVS_STRT_ARCH,FIndex);
     SendQSDataEx(QS_LOAD_ON,PABOID,-1,PIndex,trunc(dtPic1.DateTime),trunc(dtPic2.DateTime));
     //SendQSDataEx(PABOID,PMID,PIndex,dtPic1.DateTime,dtPic2.DateTime);
    End;
end;
procedure TGraphFrame.OnLoadOneTUCH(Sender: TObject);
begin
    if m_nStateLr=0 then Begin MessageDlg('Функция временно не доступна.Ожидайте.',mtWarning,[mbOk,mbCancel],0); exit; End;
    if MessageDlg('Выполнить загрузку параметра '+GetCMD(FIndex)+' ?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
//     m_pDB.FixUspdDescEvent(0,3,EVS_STRT_ARCH,FIndex);
     SendQSDataEx(QS_LOAD_ON,PABOID,PMID,PIndex,trunc(dtPic1.DateTime),trunc(dtPic2.DateTime));
    End;
end;
procedure TGraphFrame.OnFindAllTUCH(Sender: TObject);
Begin
    if m_nStateLr=0 then Begin MessageDlg('Функция временно не доступна.Ожидайте.',mtWarning,[mbOk,mbCancel],0); exit; End;
    if MessageDlg('Выполнить поиск параметра '+GetCMD(FIndex)+' во всех счетчиках?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
//     m_pDB.FixUspdDescEvent(0,3,EVS_STRT_ARCH,FIndex);
     //StartFind(FIndex,True,False);
     case m_nCF.QueryType of
          //QWR_EQL_TIME,QWR_QWERY_SHED : OnLoadAllMeter_Old;
          QWR_FIND_SHED               : StartFind(FIndex,True,False);
          QWR_QWERY_SRV               : OnLoadAllMeter_Old(1);
     End;
    End;
End;
procedure TGraphFrame.OnFindOneTUCH(Sender: TObject);
Begin
    if m_nStateLr=0 then Begin MessageDlg('Функция временно не доступна.Ожидайте.',mtWarning,[mbOk,mbCancel],0); exit; End;
    if MessageDlg('Выполнить поиск параметра '+GetCMD(FIndex)+' в счетчике?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
//     m_pDB.FixUspdDescEvent(0,3,EVS_STRT_ARCH,FIndex);
     StartFind(FIndex,True,True);
     {
     case m_nCF.QueryType of
          QWR_EQL_TIME,QWR_QWERY_SHED : OnLoadAllMeter_Old;
          QWR_FIND_SHED               : StartFind(FIndex,True,True);
     End;
     }
    End;
End;

procedure TGraphFrame.OnLoadAllMeter_Old(wFind:Word);
Var
     szDT : Integer;
     pDS  : CMessageData;
begin
     if IsGraph=True then
     Begin
      szDT := sizeof(TDateTime);
      pDS.m_swData0 := FMasterIndex;
      pDS.m_swData1 := FIndex;
      if (m_blIsLocal=True)and(m_blIsSlave=True) then FLocation := MTR_LOCAL;
      if (m_blIsLocal=False)then FLocation := MTR_REMOTE else FLocation := MTR_LOCAL;
      pDS.m_swData2 := (Integer(wFind) shl 16);
      pDS.m_swData3 := 0;
      pDS.m_swData4 := FLocation;
      Move(dtPic2.DateTime,pDS.m_sbyInfo[0]   ,szDT);
      Move(dtPic1.DateTime,pDS.m_sbyInfo[szDT],szDT);
      if (m_blIsRemCrc=True)or(m_blIsRemEco=True)or(m_blIsRemC12=True) then Begin SendRemCrcQry(FPRID,pDS);exit; End;
      SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL1_REQ,pDS);
      //SendMsgData(BOX_L3_LME,FMasterIndex,DIR_LHTOLM3,LME_STOP_POLL_REQ,pDS);
      SendMsgData(BOX_L3_LME,FMID,DIR_LHTOLM3,QL_DATA_ALLGRAPH_REQ,pDS);
    End;
end;
function TGraphFrame.ChangeColor(InputColor : TColor; Value : byte) : TColor;
var r, g, b : integer;
begin
   r := GetRValue(InputColor);
   g := GetGValue(InputColor);
   b := GetBValue(InputColor);

   r := r + Value;
   g := g + Value;
   b := b + Value;

   if (r > 255) then r := 255;
   if (g > 255) then g := 255;
   if (b > 255) then b := 255;

   Result := RGB(r, g, b);
end;

procedure TGraphFrame.OnSetNoValid(Sender: TObject);
begin
   if m_nUM.CheckPermitt(SA_USER_PERMIT_PRE,True,m_blNoCheckPass) then
   Begin
    if trunc(dtPic2.DateTime)<>trunc(dtPic1.DateTime) then exit;
    if m_blInFocus=True then
    case FSVStatus of
      SV_GRPH_ST : m_pDB.SetValidSlice(dtPic1.DateTime,FMasterIndex,FIndex,m_nValIndex,False);
      //SV_ARCH_ST : m_pDB.SetValidArch()
    end;
    OnUpdateData(self);
    m_blInFocus := False;
   end;
end;

procedure TGraphFrame.OnSetValid(Sender: TObject);
begin
   if m_nUM.CheckPermitt(SA_USER_PERMIT_PRE,True,m_blNoCheckPass) then
   Begin
    if trunc(dtPic2.DateTime)<>trunc(dtPic1.DateTime) then exit;
    if m_blInFocus=True then
    case FSVStatus of
      SV_GRPH_ST : m_pDB.SetValidSlice(dtPic1.DateTime,FMasterIndex,FIndex,m_nValIndex,True);
      //SV_ARCH_ST : m_pDB.SetValidArch()
    end;
    OnUpdateData(self);
    m_blInFocus := False;
   end;
end;

procedure TGraphFrame.OnDeleteSlice(Sender: TObject);
begin
   try
{   if (not m_pDB.IsCoverOpen)or(m_byCoverState=0) then
   begin
     MessageDlg('Крышка УСПД закрыта. Данные не могут быть удалены!', mtWarning,[mbOk, mbCancel],0);
     exit;
   end; }

   if m_nUM.CheckPermitt(SA_USER_PERMIT_PRE,True,m_blNoCheckPass) then
   Begin
    if m_blInFocus=True then
    begin
     { if not m_pDB.IsCoverOpen then
      begin
        MessageDlg('Крышка УСПД закрыта. Данные не могут быть удалены!', mtWarning,[mbOk, mbCancel],0);
        exit;
      end; }
      case FSVStatus of
        SV_GRPH_ST :
        Begin
         //if trunc(dtPic2.DateTime)<>trunc(dtPic1.DateTime) then exit;
         if FsgPGrid.Cells[1,m_nRowIndex]='' then exit;
         m_pDB.SetSlice(StrToDate(FsgPGrid.Cells[1,m_nRowIndex]),FMasterIndex,FIndex,m_nValIndex,0,False,False);
         //m_pDB.SetSlice(dtPic1.DateTime,FMasterIndex,FIndex,m_nValIndex,0,False,False);
        End;
        SV_PDPH_ST :
        Begin
         //if trunc(dtPic2.DateTime)<>trunc(dtPic1.DateTime) then exit;
         if FsgPGrid.Cells[1,m_nRowIndex]='' then exit;
         m_pDB.SetDPSlice(StrToDate(FsgPGrid.Cells[1,m_nRowIndex]),FMasterIndex,FIndex,m_nValIndex,0,False,False);
         //m_pDB.SetSlice(dtPic1.DateTime,FMasterIndex,FIndex,m_nValIndex,0,False,False);
        End;
        SV_ARCH_ST :
        Begin
         if FsgPGrid.Cells[1,m_nRowIndex]='' then exit;
         FTID := cbTariff.ItemIndex;
         if FTID=0 then Begin FTID:=-1; if not MessageDlg('Удалить значения по всем тарифам?', mtWarning,[mbOk, mbCancel],0)=mrOK then exit;End;
         if FTID>0 then FTID := FTID - 1;
         //m_pDB.SetArchSlice(StrToDate(FsgPGrid.Cells[1,m_nRowIndex]),FMasterIndex,FIndex,FTID,0,False,False);
         m_pDB.delArchSlice(StrToDate(FsgPGrid.Cells[1,m_nRowIndex]),FMasterIndex,FIndex,FTID,0,False,False);
        End;
      end;
    end;
    OnUpdateData(self);
    m_blInFocus := False;
   End;
   except
   end
end;

procedure TGraphFrame.SendQSData(nCommand,snSRVID,nCMDID:Integer;sdtBegin,sdtEnd:TDateTime);
Var
     pDS : CMessageData;
     sQC : SQWERYCMDID;
Begin
     sQC.m_snCmdID  := nCommand;
     sQC.m_sdtBegin := sdtBegin;
     sQC.m_sdtEnd   := sdtEnd;
     sQC.m_snSRVID  := snSRVID;
     sQC.m_snPrmID  := nCMDID;
     Move(sQC,pDS.m_sbyInfo[0],sizeof(SQWERYCMDID));
     if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
     if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_QWERYROUT_REQ,pDS);
End;

procedure TGraphFrame.SendQSDataEx(nCommand,snAID,snMid,nCMDID:Integer;sdtBegin,sdtEnd:TDateTime);
Var
     pDS : CMessageData;
     sQC : SQWERYCMDID;
Begin
     sQC.m_snCmdID  := nCommand;
     sQC.m_sdtBegin := sdtBegin;
     sQC.m_sdtEnd   := sdtEnd;
     sQC.m_snABOID  := snAID;
     sQC.m_snMID    := snMid;
     sQC.m_snPrmID  := nCMDID;
     Move(sQC,pDS.m_sbyInfo[0],sizeof(SQWERYCMDID));
     if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
     if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_QWERYROUT_REQ,pDS);
End;

procedure TGraphFrame.OnTcMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   FchChart.PopupMenu := Nil;
end;

{
if m_blPower=True then
   Begin
    lbT1Sum.Visible  := False;
    lbT2Sum.Visible  := False;
    lbT3Sum.Visible  := False;
    lbT4Sum.Visible  := False;
    lbSum.Visible    := False;
    lbTSSum.Visible  := False;
    lbGSum.Visible   := False;
    //lbMax.Visible   := False;
   End else
   if m_blPower=False then
   Begin
    lbT1Sum.Visible  := True;
    lbT2Sum.Visible  := True;
    lbT3Sum.Visible  := True;
    lbT4Sum.Visible  := True;
    lbTSSum.Visible  := True;
    lbGSum.Visible   := True;
    lbSum.Visible    := True;
   End;
}
procedure TGraphFrame.nTariffClick(Sender: TObject);
begin
    nTariff.Checked := not nTariff.Checked;
    nTarrCheck(nTariff.Checked);
end;

procedure TGraphFrame.nTarrCheck(Checked : Boolean);
Var
    res : Boolean;
begin
    res := not m_blPower;
    if (Checked=false) and (m_blPower=false) then
     res := False;

    lbT1Sum.Visible  := res;
    lbT2Sum.Visible  := res;
    lbT3Sum.Visible  := res;
    lbT4Sum.Visible  := res;
    lbSum.Visible    := res;
    lbTSSum.Visible  := res;
    lbGSum.Visible   := res;

    lbMax.Visible    := Checked;
    lbMin.Visible    := Checked;

    lbT1.Visible     := Checked;lbT1Min.Visible := Checked;lbT1Max.Visible := Checked;
    lbT2.Visible     := Checked;lbT2Min.Visible := Checked;lbT2Max.Visible := Checked;
    lbT3.Visible     := Checked;lbT3Min.Visible := Checked;lbT3Max.Visible := Checked;
    lbT4.Visible     := Checked;lbT4Min.Visible := Checked;lbT4Max.Visible := Checked;
end;

end.
