unit knsl3FrmMonitor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  AdvAppStyler,knsl5config,AdvOfficePager,utltypes, AdvPanel, ExtCtrls,
  AdvMenus, AdvMenuStylers, Menus, AdvToolBar, AdvToolBarStylers,
  AdvGlowButton, StdCtrls, Mask, AdvSpin, AdvOfficeButtons, Series,
  TeEngine, TeeProcs, Chart,knsl3Monitor,utlconst, AdvGroupBox, ComCtrls,
  AdvDateTimePicker, AdvTrackBar, asgcombo, ColorCombo,utlbox,utldatabase;

type
  TTFrmMonitor = class(TForm)
    MonitorStyler: TAdvFormStyler;
    AdvPanel1: TAdvPanel;
    AdvPanelStyler1: TAdvPanelStyler;
    AdvToolBarOfficeStyler1: TAdvToolBarOfficeStyler;
    AdvMenuOfficeStyler1: TAdvMenuOfficeStyler;
    advBottPannel: TAdvPanel;
    advPPannel: TAdvPanel;
    stDIs: TStaticText;
    stDIa: TStaticText;
    stDIb: TStaticText;
    stDIc: TStaticText;
    stIs: TStaticText;
    stIa: TStaticText;
    stIb: TStaticText;
    stIc: TStaticText;
    cbIs: TAdvOfficeCheckBox;
    cbIa: TAdvOfficeCheckBox;
    cbIb: TAdvOfficeCheckBox;
    cbIc: TAdvOfficeCheckBox;
    stPs: TStaticText;
    stPa: TStaticText;
    stPb: TStaticText;
    stPc: TStaticText;
    stDPc: TStaticText;
    stDPb: TStaticText;
    stDPa: TStaticText;
    stDPs: TStaticText;
    cbPs: TAdvOfficeCheckBox;
    cbPa: TAdvOfficeCheckBox;
    cbPb: TAdvOfficeCheckBox;
    cbPc: TAdvOfficeCheckBox;
    stQs: TStaticText;
    stQa: TStaticText;
    stQb: TStaticText;
    stQc: TStaticText;
    stDQc: TStaticText;
    stDQb: TStaticText;
    stDQa: TStaticText;
    stDQs: TStaticText;
    cbQs: TAdvOfficeCheckBox;
    cbQa: TAdvOfficeCheckBox;
    cbQb: TAdvOfficeCheckBox;
    cbQc: TAdvOfficeCheckBox;
    stUs: TStaticText;
    stUa: TStaticText;
    stUb: TStaticText;
    stUc: TStaticText;
    stDUc: TStaticText;
    stDUb: TStaticText;
    stDUa: TStaticText;
    stDUs: TStaticText;
    cbUs: TAdvOfficeCheckBox;
    cbUa: TAdvOfficeCheckBox;
    cbUb: TAdvOfficeCheckBox;
    cbUc: TAdvOfficeCheckBox;
    stCs: TStaticText;
    stCa: TStaticText;
    stCb: TStaticText;
    stCc: TStaticText;
    stDCc: TStaticText;
    stDCb: TStaticText;
    stDCa: TStaticText;
    stDCs: TStaticText;
    cbCs: TAdvOfficeCheckBox;
    cbCa: TAdvOfficeCheckBox;
    cbCb: TAdvOfficeCheckBox;
    cbCc: TAdvOfficeCheckBox;
    stFIs: TStaticText;
    stFIa: TStaticText;
    stFIb: TStaticText;
    stFIc: TStaticText;
    stDFIc: TStaticText;
    stDFIb: TStaticText;
    stDFIa: TStaticText;
    stDFIs: TStaticText;
    cbFIs: TAdvOfficeCheckBox;
    cbFIa: TAdvOfficeCheckBox;
    cbFIb: TAdvOfficeCheckBox;
    cbFIc: TAdvOfficeCheckBox;
    stFs: TStaticText;
    stFa: TStaticText;
    stFb: TStaticText;
    stFc: TStaticText;
    stDFc: TStaticText;
    stDFb: TStaticText;
    stDFa: TStaticText;
    stDFs: TStaticText;
    cbFs: TAdvOfficeCheckBox;
    cbFa: TAdvOfficeCheckBox;
    cbFb: TAdvOfficeCheckBox;
    cbFc: TAdvOfficeCheckBox;
    FchChart: TChart;
    stEp: TStaticText;
    stEm: TStaticText;
    stRp: TStaticText;
    stRm: TStaticText;
    stDRm: TStaticText;
    stDRp: TStaticText;
    stDEm: TStaticText;
    stDEp: TStaticText;
    cbEp: TAdvOfficeCheckBox;
    cbEm: TAdvOfficeCheckBox;
    cbRp: TAdvOfficeCheckBox;
    cbRm: TAdvOfficeCheckBox;
    rgType: TAdvOfficeRadioGroup;
    Series3: TBarSeries;
    Series4: TBarSeries;
    Series5: TBarSeries;
    Series1: TBarSeries;
    AdvPanel2: TAdvPanel;
    AdvToolBar1: TAdvToolBar;
    AdvGlowMenuButton1: TAdvGlowMenuButton;
    AdvGlowMenuButton3: TAdvGlowMenuButton;
    sePD: TAdvSpinEdit;
    cbP: TAdvOfficeCheckBox;
    cbQ: TAdvOfficeCheckBox;
    cbI: TAdvOfficeCheckBox;
    cbU: TAdvOfficeCheckBox;
    cbC: TAdvOfficeCheckBox;
    cbF: TAdvOfficeCheckBox;
    cbE: TAdvOfficeCheckBox;
    advTopMenu: TAdvPopupMenu;
    OnStart: TMenuItem;
    AdvMenuOfficeStyler2: TAdvMenuOfficeStyler;
    advViewData: TAdvPopupMenu;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    tbWindow: TAdvTrackBar;
    dtDate: TAdvDateTimePicker;
    gbLeft: TAdvGlowButton;
    gbRigt: TAdvGlowButton;
    gbPause: TAdvGlowButton;
    cmbWindow: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    lbFtime: TLabel;
    lbEtime: TLabel;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    dtBegin: TAdvDateTimePicker;
    Label3: TLabel;
    dtEnd: TAdvDateTimePicker;
    Label4: TLabel;
    procedure OnClose(Sender: TObject; var Action: TCloseAction);
    procedure OnCreate(Sender: TObject);
    procedure OnResize(Sender: TObject);
    procedure sePChange(Sender: TObject);
    procedure OnUpdate(Sender: TObject);
    procedure OnStartClick(Sender: TObject);
    procedure OnClichCB(Sender: TObject);
    procedure gbPauseClick(Sender: TObject);
    procedure cmbWindowChange(Sender: TObject);
    procedure tbWindowChange(Sender: TObject);
    procedure OnSaveToDB(Sender: TObject);
    procedure OnLoadData(Sender: TObject);
    procedure dtDateChange(Sender: TObject);
    procedure gbLeftClick(Sender: TObject);
    procedure gbRigtClick(Sender: TObject);
    procedure OnClichKTR(Sender: TObject);
  private
    { Private declarations }
     FABOID    : Integer;
     FPage     : TAdvOfficePager;
     FVMID     : Integer;
     FMID      : Integer;
     FPRID     : Integer;
     FsgVGrid  : PTAdvStringGrid;
     m_hPHandle  : MONHANDLE;
     m_hQHandle  : MONHANDLE;
     m_hIHandle  : MONHANDLE;
     m_hUHandle  : MONHANDLE;
     m_hCHandle  : MONHANDLE;
     m_hFIHandle : MONHANDLE;
     m_hFHandle  : MONHANDLE;
     m_hEHandle  : MONHANDLE;
     m_hCHand    : MONHANDLE;
     m_pCDS      : PSMONITORDATA;
     m_dtCDate   : TDateTime;
     FTimer      : TTimer;
     m_dKI,m_dTKI: Double;
     m_dKU,m_dTKU: Double;
     m_sddFabNum : String;
     m_sddPHAddres : String;
     b0 : Boolean;
     b1 : Boolean;
     b2 : Boolean;
     b3 : Boolean;
     m_blKTR     : Boolean;
     m_blPause   : Boolean;
     m_blEnabled : Boolean;
     m_nWindow   : Integer;
     m_nWindowCt : Integer;
     m_stColor   : TColor;
     m_nLastSel  : Integer;
     procedure SetTextData;
     procedure SetChart1(pD:PSMONITORDATA);
     procedure SetChart4(pD:PSMONITORDATA);
     procedure SetTable;
     procedure SetTableItemTM(nShift:Integer);
     procedure SetTableItem1(hHandle:MONHANDLE;nShift:Integer);
     procedure SetTableItem4(hHandle:MONHANDLE;nShift:Integer);
     procedure SetTableItem3(hHandle:MONHANDLE;nShift:Integer);
     procedure GetMWindowPos(pD:PSMONITORDATA;var FPos,EPos:Integer);
     function  GetEndPos(pD:PSMONITORDATA):Integer;
     function  PointToTime(nPoint:Integer):TDateTime;
     function  SelectDataSource(var hCHand:MONHANDLE):PSMONITORDATA;
     function  SelectDataSourceItem(hHandle:MONHANDLE;pC0,pC1,pC2,pC3:PTComponent):PSMONITORDATA;
     procedure DoHalfTime(Sender:TObject);dynamic;
     procedure ClearViewData;
     procedure SetChart;
     procedure SetTextItem4(hHandle:MONHANDLE;pC0,pC1,pC2,pC3,pC4:PTComponent);
     procedure SetTextItem1(hHandle:MONHANDLE;pC0,pC1:PTComponent);
     procedure SelectItemColor(pC1,pC2,pC3,pC4:PTComponent;blFocused:Boolean);
     procedure CreateMonitor(var hHandle:MONHANDLE;nCMDID,nFMT:Word);
     function  ChangeColor(InputColor : TColor; Value : Integer) : TColor;
     procedure SelectedItems;
     function  SelectKTR(nCMDID:Integer):Double;
  public
    { Public declarations }
     procedure ViewData;
     procedure Init;
  public
     property PABOID   : Integer         read FABOID    write FABOID;
     property PVMID    : Integer         read FVMID     write FVMID;
     property PMID     : Integer         read FMID      write FMID;
     property PPRID    : Integer         read FPRID     write FPRID;
     property PsgVGrid : PTAdvStringGrid read FsgVGrid  write FsgVGrid;
     property PPage    : TAdvOfficePager read FPage     write FPage;
  end;
var
  TFrmMonitor: TTFrmMonitor;
implementation
{$R *.DFM}
procedure TTFrmMonitor.OnClose(Sender: TObject; var Action: TCloseAction);
begin
     Action := caFree;
     m_nCF.m_nSetColor.PMonitorStyler := nil;
     MONDEL(m_hPHandle);
     MONDEL(m_hQHandle);
     MONDEL(m_hIHandle);
     MONDEL(m_hUHandle);
     MONDEL(m_hCHandle);
     //MONDEL(m_hFIHandle);
     MONDEL(m_hFHandle);
     MONDEL(m_hEHandle);
     FTimer.Enabled := False;
     FTimer.Destroy;
end;
procedure TTFrmMonitor.OnCreate(Sender: TObject);
begin
     m_nCF.m_nSetColor.PMonitorStyler := @MonitorStyler;
     m_nCF.m_nSetColor.SetAllStyle(m_nCF.StyleForm.ItemIndex);
     m_blEnabled := False;
     m_hPHandle  := -1;
     m_hQHandle  := -1;
     m_hIHandle  := -1;
     m_hUHandle  := -1;
     m_hCHandle  := -1;
     m_hFIHandle := -1;
     m_hFHandle  := -1;
     m_hEHandle  := -1;
     m_nLastSel  := 0;
     m_blKTR     := True;
     m_blPause   := False;
     m_stColor   := stPs.Color;
     dtDate.DateTime := Now;
     SelectedItems;
     cmbWindow.ItemIndex := 0;
     tbWindow.Max:=trunc(24*3600/((cmbWindow.ItemIndex+1)*48));
     m_nWindow   := 48;
     m_nWindowCt := 0;
     OnResize(self);
     FTimer         := TTimer.Create(Nil);
     FTimer.Enabled := True;
     FTimer.Interval:= sePD.Value*1000;
     FTimer.OnTimer := DoHalfTime;
     OnStartClick(OnStart);
end;
procedure TTFrmMonitor.Init;
Var
     nPortID : Integer;
Begin
     FPage.ActivePageIndex := 3;
     m_pDB.GetKiKU(FVMID,nPortID,m_dKI,m_dKU,m_sddFabNum,m_sddPHAddres);
     m_dTKI := 1;
     m_dTKU := 1;
     m_blKTR := True;
     stDFa.Caption := FloatToStrF(m_dKI, ffFixed, 8,3);stDFa.Font.Color := clLime;
     stDFb.Caption := FloatToStrF(m_dKU, ffFixed, 8,3);stDFb.Font.Color := clLime;
End;
procedure TTFrmMonitor.OnResize(Sender: TObject);
Var
     nWDParam,nParamCt,nWDD,i,j : Integer;
     nstCPos,nstDPos,ncbCPos:Integer;
begin
     LockWindowUpdate(Handle);
     nParamCt := 8;
     nWDParam := trunc(advPPannel.Width/nParamCt);
     nWDD     := nWDParam-(stPs.Width+cbPs.Width);
     //Width
     tbWindow.Width := advPPannel.Width-cmbWindow.Width-gbPause.Width-gbLeft.Width-dtdate.Width-gbRigt.Width-5;
     for i:=0 to ComponentCount-1 do if (Components[i].ClassType=TStaticText)and((Components[i].Tag>=0)and(Components[i].Tag<=7))
     and (Pos('D',Components[i].Name)<>0) then (Components[i] as TStaticText).Width := nWDD;
     //Position
     for j:=0 to nParamCt-1 do
     Begin
      ncbCPos := (cbPs.Left+nWDParam)*j;
      nstCPos := ncbCPos+cbPs.Width;
      nstDPos := nstCPos+stPs.Width;
      for i:=0 to ComponentCount-1 do
      Begin
       if (Components[i].ClassType=TStaticText)and(Components[i].Tag=j)and(Pos('D',Components[i].Name)=0)  then (Components[i] as TStaticText).Left := nstCPos;
       if (Components[i].ClassType=TStaticText)and(Components[i].Tag=j)and(Pos('D',Components[i].Name)<>0) then (Components[i] as TStaticText).Left := nstDPos;
       if (Components[i].ClassType=TAdvOfficeCheckBox)and(Components[i].Tag=j) then (Components[i] as TAdvOfficeCheckBox).Left := ncbCPos;
      End;
     End;
     tbWindow.Left := cmbWindow.Left+cmbWindow.Width;
     gbPause.Left  := cmbWindow.Left+cmbWindow.Width+tbWindow.Width;
     gbLeft.Left   := gbPause.Left+gbPause.Width;
     dtDate.Left   := gbLeft.Left+gbLeft.Width;
     gbRigt.Left   := dtDate.Left+dtDate.Width;
     lbFtime.Top   := FchChart.Height-lbFtime.Height;
     lbEtime.Top   := lbFtime.Top;
     lbFtime.Left  := cmbWindow.Left+lbEtime.Width;
     lbEtime.Left  := advPPannel.Width-3*lbEtime.Width;
     LockWindowUpdate(0);
end;
procedure TTFrmMonitor.ViewData;
Begin
     ClearViewData;
     SetChart;
     SetTable;
     SetTextData;
End;
procedure TTFrmMonitor.SetChart;
Begin
     if m_pCDS=Nil then exit;
     if m_pCDS.m_nSize=1 then SetChart1(m_pCDS);
     if m_pCDS.m_nSize=4 then SetChart4(m_pCDS);
     if m_blPause=False then tbWindow.Position := trunc(m_pCDS.m_nCount*sePD.Value/m_nWindow);
End;
procedure TTFrmMonitor.ClearViewData;
Begin
     FchChart.Series[0].Clear;
     FchChart.Series[1].Clear;
     FchChart.Series[2].Clear;
     FchChart.Series[3].Clear;
End;
procedure TTFrmMonitor.SetChart1(pD:PSMONITORDATA);
Var
     i,FPos,EPos : Integer;
     dKTR : Double;
Begin
     GetMWindowPos(pD,FPos,EPos);
     dKTR := SelectKTR(pD.CmdID);
     for i:=FPos to EPos-1 do
     Begin
      //if i>pD.m_nCount-1 Then exit;
      if (i=FPos)  then lbFtime.Caption := TimeTostr(PointToTime(i));
      if i=(EPos-1)then lbFtime.Caption := TimeTostr(PointToTime(i));
      if b0=True then FchChart.Series[0].AddXY(i,dKTR*pD.Items1[i].Value, ' ', clBlue);
     End;
End;
procedure TTFrmMonitor.SetChart4(pD:PSMONITORDATA);
Var
     i,FPos,EPos : Integer;
     dKTR : Double;
Begin
     GetMWindowPos(pD,FPos,EPos);
     dKTR := SelectKTR(pD.CmdID);
     for i:=FPos to EPos-1 do
     Begin
      //if i>pD.m_nCount-1 Then exit;
      if (i=FPos)  then lbFtime.Caption := TimeTostr(PointToTime(i));
      if i=(EPos-1)then lbEtime.Caption := TimeTostr(PointToTime(i));
      if b0=True then FchChart.Series[0].AddXY(i, dKTR*pD.Items2[i].Value[0], ' ', clBlue);
      if b1=True then FchChart.Series[1].AddXY(i, dKTR*pD.Items2[i].Value[1], ' ', clYellow);
      if b2=True then FchChart.Series[2].AddXY(i, dKTR*pD.Items2[i].Value[2], ' ', clLime);
      if b3=True then FchChart.Series[3].AddXY(i, dKTR*pD.Items2[i].Value[3], ' ', clRed);
     End;
End;
procedure TTFrmMonitor.SetTable;
Begin
      SetTableItemTM(0);
      SetTableItem4(m_hUHandle,3);
      SetTableItem4(m_hIHandle,7);
      SetTableItem3(m_hCHandle,11);
      SetTableItem4(m_hPHandle,14);
      SetTableItem4(m_hQHandle,18);
      SetTableItem1(m_hFHandle,22);
End;
procedure TTFrmMonitor.SetTableItem4(hHandle:MONHANDLE;nShift:Integer);
Var
     pD : PSMONITORDATA;
     i,j,FPos,EPos : Integer;
     dKTR : Double;
Begin
     pD := MONGETBUFFER(hHandle,m_dtCDate);
     if pD=Nil then exit;
     GetMWindowPos(pD,FPos,EPos);
     dKTR := SelectKTR(pD.CmdID);
     j := 0;
     for i:=EPos-1 downto FPos do
     Begin
      if j>FsgVGrid.VisibleRowCount then break;
      if (Active=True) then
      Begin
       //if i>pD.m_nCount-1 Then exit;
       FsgVGrid.Cells[nShift+0,1+j]  := FloatToStrF(dKTR*pD.Items2[i].Value[0], ffFixed, 8,3);
       FsgVGrid.Cells[nShift+1,1+j]  := FloatToStrF(dKTR*pD.Items2[i].Value[1], ffFixed, 8,3);
       FsgVGrid.Cells[nShift+2,1+j]  := FloatToStrF(dKTR*pD.Items2[i].Value[2], ffFixed, 8,3);
       FsgVGrid.Cells[nShift+3,1+j]  := FloatToStrF(dKTR*pD.Items2[i].Value[3], ffFixed, 8,3);
      End;
      j := j + 1;
     End;
End;
procedure TTFrmMonitor.SetTableItem3(hHandle:MONHANDLE;nShift:Integer);
Var
     pD : PSMONITORDATA;
     i,j,FPos,EPos : Integer;
     dKTR : Double;
Begin
     pD := MONGETBUFFER(hHandle,m_dtCDate);
     if pD=Nil then exit;
     GetMWindowPos(pD,FPos,EPos);
     dKTR := SelectKTR(pD.CmdID);
     j := 0;
     for i:=EPos-1 downto FPos do
     Begin
      if j>FsgVGrid.VisibleRowCount then break;
      if (Active=True) then
      Begin
       //if i>pD.m_nCount-1 Then exit;
       FsgVGrid.Cells[nShift+0,1+j]  := FloatToStrF(dKTR*pD.Items2[i].Value[1], ffFixed, 8,3);
       FsgVGrid.Cells[nShift+1,1+j]  := FloatToStrF(dKTR*pD.Items2[i].Value[2], ffFixed, 8,3);
       FsgVGrid.Cells[nShift+2,1+j]  := FloatToStrF(dKTR*pD.Items2[i].Value[3], ffFixed, 8,3);
      End;
      j := j + 1;
     End;
End;
procedure TTFrmMonitor.SetTableItem1(hHandle:MONHANDLE;nShift:Integer);
Var
     pD : PSMONITORDATA;
     i,j,FPos,EPos : Integer;
     dKTR : Double;
Begin
     pD := MONGETBUFFER(hHandle,m_dtCDate);
     if pD=Nil then exit;
     GetMWindowPos(pD,FPos,EPos);
     dKTR := SelectKTR(pD.CmdID);
     j := 0;
     for i:=EPos-1 downto FPos do
     Begin
      //if i>pD.m_nCount-1 Then exit;
      if j>FsgVGrid.VisibleRowCount then break;
      if (Active=True) then
      FsgVGrid.Cells[nShift+0,1+j]  := FloatToStrF(dKTR*pD.Items1[i].Value, ffFixed, 8,3);
      j := j + 1;
     End;
End;
procedure TTFrmMonitor.SetTableItemTM(nShift:Integer);
Var
     sTime : TDateTime;
     i,j,FPos,EPos : Integer;
Begin
     if m_pCDS=Nil then exit;
     GetMWindowPos(m_pCDS,FPos,EPos);
     j := 0;
     for i:=EPos-1 downto FPos do
     Begin
      if j>FsgVGrid.VisibleRowCount then break;
      if (Active=True) then
      Begin
       sTime := PointToTime(i);
       FsgVGrid.Cells[nShift+0,1+j]  := IntToStr(j);
       FsgVGrid.Cells[nShift+1,1+j]  := DateToStr(sTime);
       FsgVGrid.Cells[nShift+2,1+j]  := TimeToStr(sTime);
      End;
      j := j + 1;
     End;
End;
procedure TTFrmMonitor.GetMWindowPos(pD:PSMONITORDATA;var FPos,EPos:Integer);
Var
     nPos : Integer;
Begin
     EPos := GetEndPos(pD);
     nPos := EPos-m_nWindow;
     if (EPos-m_nWindow)<0 then nPos := 0;
     FPos := nPos;
End;
function TTFrmMonitor.GetEndPos(pD:PSMONITORDATA):Integer;
Var
     nPos : Integer;
Begin
     if m_blPause=False then  Result := pD.m_nCount else
     if m_blPause=True  then
     Begin
      //tbWindow.Position := trunc(pD.m_nCount*sePD.Value/m_nWindow);
      nPos := trunc(tbWindow.Position*m_nWindow/sePD.Value);
      if (nPos>m_nWindowCt) then nPos := m_nWindowCt;
      Result := nPos;
     End;
End;
function  TTFrmMonitor.PointToTime(nPoint:Integer):TDateTime;
Var
     h,m,s : Word;
     nSec  : Integer;
     sTime : TDateTime;
Begin
     try
      nSec := nPoint*sePD.Value;
      h := nSec div 3600; s := nSec mod 3600;
      m := s div 60;
      s := s mod 60;
      if h<23 then Result := EncodeTime(h,m,s,0)+ trunc(dtDate.DateTime) else
      if h>23 then Result := Now;
     except

     end;
End;
procedure TTFrmMonitor.SetTextData;
Begin
     SetTextItem4(m_hPHandle,@cbP,@stDPs,@stDPa,@stDPb,@stDPc);
     SetTextItem4(m_hQHandle,@cbQ,@stDQs,@stDQa,@stDQb,@stDQc);
     SetTextItem4(m_hIHandle,@cbI,@stDIs,@stDIa,@stDIb,@stDIc);
     SetTextItem4(m_hUHandle,@cbU,@stDUs,@stDUa,@stDUb,@stDUc);
     SetTextItem4(m_hCHandle,@cbC,@stDCs,@stDCa,@stDCb,@stDCc);
     SetTextItem1(m_hFHandle,@cbF,@stDFs);
     SetTextItem4(m_hEHandle,@cbE,@stDEp,@stDEm,@stDRp,@stDRm);
End;
procedure TTFrmMonitor.SetTextItem4(hHandle:MONHANDLE;pC0,pC1,pC2,pC3,pC4:PTComponent);
Var
     pD   : PSMONITORDATA;
     dKTR : Double;
Begin
     if ((pC0^ as TAdvOfficeCheckBox).Checked=True) then
     Begin
      pD   := MONGETBUFFER(hHandle,m_dtCDate);
      dKTR := SelectKTR(pD.CmdID);
      if (pD<>Nil)and(pD.m_nCount>0) then
      Begin
       (pC1^ as TStaticText).Caption := FloatToStrF(dKTR*pD.Items2[pD.m_nCount-1].Value[0],ffFixed,8,3);
       (pC2^ as TStaticText).Caption := FloatToStrF(dKTR*pD.Items2[pD.m_nCount-1].Value[1],ffFixed,8,3);
       (pC3^ as TStaticText).Caption := FloatToStrF(dKTR*pD.Items2[pD.m_nCount-1].Value[2],ffFixed,8,3);
       (pC4^ as TStaticText).Caption := FloatToStrF(dKTR*pD.Items2[pD.m_nCount-1].Value[3],ffFixed,8,3);
      End;
     End;
End;
procedure TTFrmMonitor.SetTextItem1(hHandle:MONHANDLE;pC0,pC1:PTComponent);
Var
     pD   : PSMONITORDATA;
     dKTR : Double;
Begin
     if ((pC0^ as TAdvOfficeCheckBox).Checked=True) then
     Begin
      pD := MONGETBUFFER(hHandle,m_dtCDate);
      dKTR := SelectKTR(pD.CmdID);
      if (pD<>Nil)and(pD.m_nCount>0) then
      Begin
       (pC1^ as TStaticText).Caption := FloatToStrF(dKTR*pD.Items1[pD.m_nCount-1].Value,ffFixed,8,3);
      End;
     End;
End;
function TTFrmMonitor.SelectDataSource(var hCHand:MONHANDLE):PSMONITORDATA;
Begin
     Result := Nil;
     if rgType.ItemIndex=0 then Begin hCHand:=m_hPHandle;Result := SelectDataSourceItem(m_hPHandle ,@cbPs, @cbPa ,@cbPb ,@cbPc);End else
     if rgType.ItemIndex=1 then Begin hCHand:=m_hQHandle;Result := SelectDataSourceItem(m_hQHandle ,@cbQs, @cbQa ,@cbQb ,@cbQc);End else
     if rgType.ItemIndex=2 then Begin hCHand:=m_hIHandle;Result := SelectDataSourceItem(m_hIHandle ,@cbIs, @cbIa ,@cbIb ,@cbIc);End else
     if rgType.ItemIndex=3 then Begin hCHand:=m_hUHandle;Result := SelectDataSourceItem(m_hUHandle ,@cbUs, @cbUa ,@cbUb ,@cbUc);End else
     if rgType.ItemIndex=4 then Begin hCHand:=m_hCHandle;Result := SelectDataSourceItem(m_hCHandle ,@cbCs, @cbCa ,@cbCb ,@cbCc);End else
     if rgType.ItemIndex=5 then Begin hCHand:=m_hFIHandle;Result := SelectDataSourceItem(m_hFIHandle,@cbFIs,@cbFIa,@cbFIb,@cbFIc);End else
     if rgType.ItemIndex=6 then Begin hCHand:=m_hFHandle;Result := SelectDataSourceItem(m_hFHandle ,@cbFs, @cbFa ,@cbFb ,@cbFc);End else
     if rgType.ItemIndex=7 then Begin hCHand:=m_hEHandle;Result := SelectDataSourceItem(m_hEHandle ,@cbEp, @cbEm ,@cbRp ,@cbRm);End;
End;
function TTFrmMonitor.SelectDataSourceItem(hHandle:MONHANDLE;pC0,pC1,pC2,pC3:PTComponent):PSMONITORDATA;
Begin
     b0 := (pC0^ as TAdvOfficeCheckBox).Checked;
     b1 := (pC1^ as TAdvOfficeCheckBox).Checked;
     b2 := (pC2^ as TAdvOfficeCheckBox).Checked;
     b3 := (pC3^ as TAdvOfficeCheckBox).Checked;
     Result := MONGETBUFFER(hHandle,m_dtCDate);
End;
procedure TTFrmMonitor.sePChange(Sender: TObject);
begin
     if cbP.Checked=True then MONSETTM(sePD.Value,m_hPHandle);
     if cbQ.Checked=True then MONSETTM(sePD.Value,m_hQHandle);
     if cbI.Checked=True then MONSETTM(sePD.Value,m_hIHandle);
     if cbU.Checked=True then MONSETTM(sePD.Value,m_hUHandle);
     if cbC.Checked=True then MONSETTM(sePD.Value,m_hCHandle);
     if cbF.Checked=True then MONSETTM(sePD.Value,m_hFHandle);
     if cbE.Checked=True then MONSETTM(sePD.Value,m_hEHandle);
end;
function TTFrmMonitor.ChangeColor(InputColor : TColor; Value : Integer) : TColor;
Var
     r, g, b : integer;
begin
     r := GetRValue(InputColor);
     g := GetGValue(InputColor);
     b := GetBValue(InputColor);
     r := r + Value;
     g := g + Value;
     b := b + Value;
     if (r > 255) then r := 255; if  (r < 0)  then r := 0;
     if (g > 255) then g := 255; if  (g < 0)  then g := 0;
     if (b > 255) then b := 255; if  (b < 0)  then b := 0;
     Result := RGB(r, g, b);
end;
procedure TTFrmMonitor.SelectItemColor(pC1,pC2,pC3,pC4:PTComponent;blFocused:Boolean);
Var
     Color : TColor;
Begin
     Color := m_stColor;
     if blFocused=True then Color := ChangeColor(Color,50);
     (pC1^ as TStaticText).Color := Color;
     (pC2^ as TStaticText).Color := Color;
     (pC3^ as TStaticText).Color := Color;
     (pC4^ as TStaticText).Color := Color;
End;
procedure TTFrmMonitor.CreateMonitor(var hHandle:MONHANDLE;nCMDID,nFMT:Word);
Begin
     if MONASSIGNED(hHandle)=-1 then
     hHandle := MONCREATE(FPRID,FMID,FVMID,nCMDID,sePD.Value,nFMT,dtBegin.DateTime,dtEnd.DateTime);
     MONSTART(hHandle);
End;
procedure TTFrmMonitor.OnUpdate(Sender: TObject);
begin
     ViewData;
end;
procedure TTFrmMonitor.OnStartClick(Sender: TObject);
begin
    if (Sender As TMenuItem).Caption='Запустить' then
    Begin
     (Sender As TMenuItem).Caption := 'Остановить';
     m_blEnabled := True;
     if cbP.Checked=True then CreateMonitor(m_hPHandle,QRY_MGAKT_POW_A,MON_FMT_1IN3);
     if cbQ.Checked=True then CreateMonitor(m_hQHandle,QRY_MGREA_POW_A,MON_FMT_1IN3);
     if cbI.Checked=True then CreateMonitor(m_hIHandle,QRY_I_PARAM_A,MON_FMT_1IN3);
     if cbU.Checked=True then CreateMonitor(m_hUHandle,QRY_U_PARAM_A,MON_FMT_1IN3);
     if cbC.Checked=True then CreateMonitor(m_hCHandle,QRY_KOEF_POW_A,MON_FMT_1IN3);
     if cbF.Checked=True then CreateMonitor(m_hFHandle,QRY_FREQ_NET,MON_FMT_1IN1);
     if cbE.Checked=True then CreateMonitor(m_hEHandle,QRY_ENERGY_SUM_EP,MON_FMT_1IN4);
    End else
    if (Sender As TMenuItem).Caption='Остановить' then
    Begin
     m_blEnabled := False;
     (Sender As TMenuItem).Caption := 'Запустить';
     if cbP.Checked=True then MONSTOP(m_hPHandle);
     if cbQ.Checked=True then MONSTOP(m_hQHandle);
     if cbI.Checked=True then MONSTOP(m_hIHandle);
     if cbU.Checked=True then MONSTOP(m_hUHandle);
     if cbC.Checked=True then MONSTOP(m_hCHandle);
     if cbF.Checked=True then MONSTOP(m_hFHandle);
     if cbE.Checked=True then MONSTOP(m_hEHandle);
    End;

    m_pCDS := SelectDataSource(m_hCHand);
    dtDate.DateTime  := m_pCDS.m_dtDate;
    dtBegin.DateTime := m_pCDS.m_dtBegin;
    dtEnd.DateTime   := m_pCDS.m_dtEnd;
    sePD.Value       := m_pCDS.m_nPeriod;
    m_dtCDate        := dtDate.DateTime;
end;
procedure TTFrmMonitor.DoHalfTime(Sender:TObject);
Begin
     if (m_blEnabled=True)and(m_blMinimized=False) then ViewData;
     if FTimer<>Nil then
     FTimer.Interval:= sePD.Value*1000;
End;
procedure TTFrmMonitor.OnClichCB(Sender: TObject);
begin
     m_pCDS := SelectDataSource(m_hCHand);
     //m_pCDS := MONLOAD(m_hCHand,m_dtCDate);
     ViewData;
     SelectedItems;
end;
procedure TTFrmMonitor.SelectedItems;
Begin
     if m_nLastSel=0 then SelectItemColor(@stDPs,@stDPa,@stDPb,@stDPc,False) else
     if m_nLastSel=1 then SelectItemColor(@stDQs,@stDQa,@stDQb,@stDQc,False) else
     if m_nLastSel=2 then SelectItemColor(@stDIs,@stDIa,@stDIb,@stDIc,False) else
     if m_nLastSel=3 then SelectItemColor(@stDUs,@stDUa,@stDUb,@stDUc,False) else
     if m_nLastSel=4 then SelectItemColor(@stDCs,@stDCa,@stDCb,@stDCc,False) else
     if m_nLastSel=6 then SelectItemColor(@stDFs,@stDFa,@stDFb,@stDFc,False) else
     if m_nLastSel=7 then SelectItemColor(@stDEp,@stDEm,@stDRp,@stDRm,False);
     if rgType.ItemIndex=0 then SelectItemColor(@stDPs,@stDPa,@stDPb,@stDPc,True) else
     if rgType.ItemIndex=1 then SelectItemColor(@stDQs,@stDQa,@stDQb,@stDQc,True) else
     if rgType.ItemIndex=2 then SelectItemColor(@stDIs,@stDIa,@stDIb,@stDIc,True) else
     if rgType.ItemIndex=3 then SelectItemColor(@stDUs,@stDUa,@stDUb,@stDUc,True) else
     if rgType.ItemIndex=4 then SelectItemColor(@stDCs,@stDCa,@stDCb,@stDCc,True) else
     if rgType.ItemIndex=6 then SelectItemColor(@stDFs,@stDFa,@stDFb,@stDFc,True) else
     if rgType.ItemIndex=7 then SelectItemColor(@stDEp,@stDEm,@stDRp,@stDRm,True);
     m_nLastSel := rgType.ItemIndex;
End;
procedure TTFrmMonitor.gbPauseClick(Sender: TObject);
Var
     pD : PSMONITORDATA;
begin
     if gbPause.Caption='Пауза' then
     Begin
      gbPause.Caption := 'Старт';
      m_blPause := True;
      if m_pCDS=Nil then exit;
      m_nWindowCt := m_pCDS.m_nCount;
     End else
     if gbPause.Caption='Старт' then
     Begin
      gbPause.Caption := 'Пауза';
      m_blPause := False;
     End;
end;

procedure TTFrmMonitor.cmbWindowChange(Sender: TObject);
begin
     tbWindow.Max:=trunc(24*3600/((cmbWindow.ItemIndex+1)*48));
     m_nWindow := (cmbWindow.ItemIndex+1)*48;
end;

procedure TTFrmMonitor.tbWindowChange(Sender: TObject);
begin
     if m_blPause=True then
      ViewData;
end;

procedure TTFrmMonitor.OnSaveToDB(Sender: TObject);
Begin
     if m_pCDS=Nil then exit;
     m_pCDS.m_dtBegin := dtBegin.DateTime;
     m_pCDS.m_dtEnd   := dtEnd.DateTime;
     m_pCDS.m_nPeriod := sePD.Value;
     MONSAVE(m_hCHand,m_dtCDate);
     {
     MONSAVE(m_hPHandle,m_dtCDate);
     MONSAVE(m_hQHandle,m_dtCDate);
     MONSAVE(m_hIHandle,m_dtCDate);
     MONSAVE(m_hUHandle,m_dtCDate);
     MONSAVE(m_hCHandle,m_dtCDate);
     MONSAVE(m_hFHandle,m_dtCDate);
     MONSAVE(m_hEHandle,m_dtCDate);
     }
end;

procedure TTFrmMonitor.OnLoadData(Sender: TObject);
begin
     //if m_pCDS=Nil then exit;
     //MONLOAD(m_hCHand);
     //if m_blEnabled=False then exit;
     //m_pCDS := SelectDataSource(m_hCHand);
     m_pCDS := MONLOAD(m_hCHand,m_dtCDate);
     m_nWindowCt      := m_pCDS.m_nCount;
     sePD.Value       := m_pCDS.m_nPeriod;
     dtDate.DateTime  := m_pCDS.m_dtDate;
     dtBegin.DateTime := m_pCDS.m_dtBegin;
     dtEnd.DateTime   := m_pCDS.m_dtEnd;
     sePD.Value       := m_pCDS.m_nPeriod;
     m_dtCDate        := dtDate.DateTime;

     {
     MONLOAD(m_hPHandle,m_dtCDate);
     MONLOAD(m_hQHandle,m_dtCDate);
     MONLOAD(m_hIHandle,m_dtCDate);
     MONLOAD(m_hUHandle,m_dtCDate);
     MONLOAD(m_hCHandle,m_dtCDate);
     MONLOAD(m_hFHandle,m_dtCDate);
     MONLOAD(m_hEHandle,m_dtCDate);
     }
end;

procedure TTFrmMonitor.dtDateChange(Sender: TObject);
begin
     if trunc(m_dtCDate)<>trunc((Sender as TAdvDateTimePicker).DateTime) then
     Begin
      m_blEnabled := False;
      m_blPause   := True;
     End else
     if trunc((Sender as TAdvDateTimePicker).DateTime)=trunc(Now) then
     Begin
      m_blEnabled := True;
      m_blPause   := False;
     End;
     m_dtCDate   := (Sender as TAdvDateTimePicker).DateTime;
end;

procedure TTFrmMonitor.gbLeftClick(Sender: TObject);
begin
     dtDate.DateTime := dtDate.DateTime - 1;
end;

procedure TTFrmMonitor.gbRigtClick(Sender: TObject);
begin
     dtDate.DateTime := dtDate.DateTime + 1;
end;
function TTFrmMonitor.SelectKTR(nCMDID:Integer):Double;
Begin
     case nCMDID of
          QRY_MGAKT_POW_A,
          QRY_MGREA_POW_A,
          QRY_ENERGY_SUM_EP : Result := m_dTKI*m_dTKU;
          QRY_I_PARAM_A     : Result := m_dTKI;
          QRY_U_PARAM_A     : Result := m_dTKU;
          QRY_KOEF_POW_A    : Result := 1;
          QRY_FREQ_NET      : Result := 1;
     End;
End;
procedure TTFrmMonitor.OnClichKTR(Sender: TObject);
begin
      //Без учета КТР
     if (Sender as TMenuItem).Caption='Без учета КТР' then
     Begin
      if m_dKI=0 then m_dKI:=1;
      if m_dKU=0 then m_dKU:=1;
      m_dTKI := 1/m_dKI;
      m_dTKU := 1/m_dKU;
      m_blKTR := False;
      (Sender as TMenuItem).Caption :='С учетом КТР';
      stDFa.Caption := FloatToStrF(1, ffFixed, 8,3);stDFa.Font.Color := clRed;
      stDFb.Caption := FloatToStrF(1, ffFixed, 8,3);stDFb.Font.Color := clRed;
     End else
     if (Sender as TMenuItem).Caption='С учетом КТР' then
     Begin
      m_dTKI := 1;
      m_dTKU := 1;
      m_blKTR := True;
      (Sender as TMenuItem).Caption :='Без учета КТР';
      stDFa.Caption := FloatToStrF(m_dKI, ffFixed, 8,3);stDFa.Font.Color := clLime;
      stDFb.Caption := FloatToStrF(m_dKU, ffFixed, 8,3);stDFb.Font.Color := clLime;
     End;
     if m_blEnabled=True then ViewData;
end;

end.
