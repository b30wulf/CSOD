unit knsl3datafinder;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  AdvGlowButton, AdvProgressBar, GradientLabel, ComCtrls, AdvOfficeButtons,
  ImgList, AdvToolBar, AdvToolBarStylers, AdvPanel, AdvAppStyler, StdCtrls,
  ExtCtrls, AdvOfficeStatusBar, AdvOfficeStatusBarStylers,knsl3FHModule,utltypes,
  AdvProgr,utlbox,utlconst,knsl5config,knsl3recalcmodule;

type
  TTDataFinder = class(TForm)
    AdvPanel3: TAdvPanel;
    AdvPanel1: TAdvPanel;
    Label2: TLabel;
    AdvToolBar1: TAdvToolBar;
    bClearEv: TAdvToolBarButton;
    bEnablEv: TAdvToolBarButton;
    bDisablEv: TAdvToolBarButton;
    EventBoxStyler: TAdvFormStyler;
    AdvPanelStyler3: TAdvPanelStyler;
    AdvToolBarOfficeStyler1: TAdvToolBarOfficeStyler;
    ImageList2: TImageList;
    m_sdSaveLog: TSaveDialog;
    dtETime: TDateTimePicker;
    dtFTime: TDateTimePicker;
    GradientLabel1: TGradientLabel;
    cbm_nPar6: TAdvOfficeCheckBox;
    advStatus: TAdvOfficeStatusBar;
    AdvOfficeStatusBarOfficeStyler1: TAdvOfficeStatusBarOfficeStyler;
    cbm_nArchEN111: TGradientLabel;
    GradientLabel2: TGradientLabel;
    GradientLabel3: TGradientLabel;
    Label1: TLabel;
    cbm_nPriDay: TAdvOfficeCheckBox;
    cbm_nPriMonth: TAdvOfficeCheckBox;
    cbm_nPri30: TAdvOfficeCheckBox;
    cbm_nNakDay: TAdvOfficeCheckBox;
    cbm_nNakMonth: TAdvOfficeCheckBox;
    AdvToolBarButton1: TAdvToolBarButton;
    pbm_sBTIProgress: TAdvProgress;
    Label3: TLabel;
    Label4: TLabel;
    cbAllAbon: TAdvOfficeCheckBox;
    cbRecalc: TAdvOfficeCheckBox;
    GradientLabel4: TGradientLabel;
    cbm_byCurrent: TAdvOfficeCheckBox;
    cbm_byCorrTM: TAdvOfficeCheckBox;
    cbm_bySumEn: TAdvOfficeCheckBox;
    cbm_byMAP: TAdvOfficeCheckBox;
    cbm_byMRAP: TAdvOfficeCheckBox;
    cbm_byU: TAdvOfficeCheckBox;
    cbm_byI: TAdvOfficeCheckBox;
    GradientLabel5: TGradientLabel;
    GradientLabel6: TGradientLabel;
    cbm_byJEn: TAdvOfficeCheckBox;
    cbm_byJ0: TAdvOfficeCheckBox;
    cbm_byJ1: TAdvOfficeCheckBox;
    cbm_byJ2: TAdvOfficeCheckBox;
    cbm_byJ3: TAdvOfficeCheckBox;
    ewew: TGradientLabel;
    cbm_byPNetEn: TAdvOfficeCheckBox;
    cbm_byPNetU: TAdvOfficeCheckBox;
    cbm_byPNetI: TAdvOfficeCheckBox;
    cbm_byPNetFi: TAdvOfficeCheckBox;
    cbm_byPNetCosFi: TAdvOfficeCheckBox;
    cbm_nArchEN: TAdvOfficeCheckBox;
    cbm_byPNetF: TAdvOfficeCheckBox;
    cbm_byPNetP: TAdvOfficeCheckBox;
    cbm_byPNetQ: TAdvOfficeCheckBox;
    cbm_byMPNetEn: TAdvOfficeCheckBox;
    cbm_byFreq: TAdvOfficeCheckBox;
    cbm_byCosFi: TAdvOfficeCheckBox;
    procedure OnFormCreate(Sender: TObject);
    procedure OnFindHoles(Sender: TObject);
    procedure bEnablEvClick(Sender: TObject);
    procedure bDisablEvClick(Sender: TObject);
    procedure bClearEvClick(Sender: TObject);
    procedure OnClickCurr(Sender: TObject);
    procedure OnClickEvents(Sender: TObject);
    procedure OnClickAEN(Sender: TObject);
    procedure OnClickANetEN(Sender: TObject);
  private
    { Private declarations }
    m_nBoxQry : Integer;
    FTimer    : TTimer;
    m_blState : Boolean;
    procedure GetStatus(var FSVStatus,nCMD:Byte);
    procedure DoHalfTime(Sender:TObject);dynamic;
  public
    { Public declarations }
    m_pTRI  : CTreeIndex;
    procedure OnStopFind;
    procedure Init;
    //procedure OnFindProceed;
    //procedure On
  end;

var
  TDataFinder: TTDataFinder;

implementation

{$R *.DFM}

procedure TTDataFinder.OnFormCreate(Sender: TObject);
begin
     m_nDataFinder    := False;
     m_blState        := False;
     dtEtime.DateTime := Now;
     dtFtime.DateTime := Now;
     FTimer         := TTimer.Create(Nil);
     FTimer.Enabled := False;
     FTimer.Interval:= 1000;
     FTimer.OnTimer := DoHalfTime;
end;
procedure TTDataFinder.Init;
Begin
     if m_pTRI.PVID<>65535 then cbAllAbon.Enabled := False else
     cbAllAbon.Enabled := True;
     OnClickCurr(self);
     OnClickEvents(self);
     OnClickAEN(self);
     OnClickANetEN(self);
End;
{
  QFH_ARCH_EN                  = $0000000000000001;
  QFH_ENERGY_DAY_EP            = $0000000000000002;
  QFH_ENERGY_MON_EP            = $0000000000000004;
  QFH_SRES_ENR_EP              = $0000000000000008;
  QFH_NAK_EN_DAY_EP            = $0000000000000010;
  QFH_NAK_EN_MONTH_EP          = $0000000000000020;
  QFH_CURR                     = $0000000000000040;
  QFH_CURR_SUMM                = $0000000000000080;
  QFH_CURR_MAP                 = $0000000000000100;
  QFH_CURR_MRP                 = $0000000000000200;
  QFH_CURR_U                   = $0000000000000400;
  QFH_CURR_I                   = $0000000000000800;
  QFH_CURR_F                   = $0000000000001000;
  QFH_CORR_TIME                = $0000000000002000;
  QFH_POD_TRYB_HEAT            = $0000000000004000;
  QFH_JUR_EN                   = $0000000000008000;
  QFH_JUR_0                    = $0000000000010000;
  QFH_JUR_1                    = $0000000000020000;
  QFH_JUR_2                    = $0000000000040000;
  QFH_ANET_EN                  = $0000000000080000;
  QFH_ANET_U                   = $0000000000100000;
  QFH_ANET_I                   = $0000000000200000;
  QFH_ANET_FI                  = $0000000000400000;
  QFH_ANET_CFI                 = $0000000000800000;
  QFH_ANET_F                   = $0000000001000000;
  QFH_ANET_P                   = $0000000002000000;
  QFH_ANET_Q                   = $0000000004000000;
}
procedure TTDataFinder.OnFindHoles(Sender: TObject);
Var
   dwLoMask   : int64;
   dwOne      : int64;
   ldtFTime,ldtETime : TDateTime;
   nAID,nVMID : Integer;
begin
    dwOne     := 1;
    dwLoMask  := 0;
    if cbm_nArchEN.Checked=True   then dwLoMask := dwLoMask or (QFH_ARCH_EN);
    if cbm_nPriDay.Checked=True   then dwLoMask := dwLoMask or (QFH_ENERGY_DAY_EP);
    if cbm_nPriMonth.Checked=True then dwLoMask := dwLoMask or (QFH_ENERGY_MON_EP);
    if cbm_nPri30.Checked=True    then dwLoMask := dwLoMask or (QFH_SRES_ENR_EP);
    if cbm_nNakDay.Checked=True   then dwLoMask := dwLoMask or (QFH_NAK_EN_DAY_EP);
    if cbm_nNakMonth.Checked=True then dwLoMask := dwLoMask or (QFH_NAK_EN_MONTH_EP);

    if cbm_byCurrent.Checked=True then dwLoMask := dwLoMask or (QFH_CURR);
    if cbm_bySumEn.Checked=True   then dwLoMask := dwLoMask or (QFH_CURR_SUMM);
    if cbm_byMAP.Checked=True     then dwLoMask := dwLoMask or (QFH_CURR_MAP);
    if cbm_byMRAP.Checked=True    then dwLoMask := dwLoMask or (QFH_CURR_MRP);
    if cbm_byU.Checked=True       then dwLoMask := dwLoMask or (QFH_CURR_U);
    if cbm_byI.Checked=True       then dwLoMask := dwLoMask or (QFH_CURR_I);
    if cbm_byFreq.Checked=True    then dwLoMask := dwLoMask or (QFH_CURR_F);
    if cbm_byCosFi.Checked=True   then dwLoMask := dwLoMask or (QFH_CURR_CFI);
    if cbm_byCorrTM.Checked=True  then dwLoMask := dwLoMask or (QFH_CORR_TIME);

    if cbm_nPar6.Checked=True     then dwLoMask := dwLoMask or (QFH_POD_TRYB_HEAT);

    if cbm_byJEn.Checked=True     then dwLoMask := dwLoMask or (QFH_JUR_EN);
    if cbm_byJ0.Checked=True      then dwLoMask := dwLoMask or (QFH_JUR_0);
    if cbm_byJ1.Checked=True      then dwLoMask := dwLoMask or (QFH_JUR_1);
    if cbm_byJ2.Checked=True      then dwLoMask := dwLoMask or (QFH_JUR_2);
    if cbm_byJ3.Checked=True      then dwLoMask := dwLoMask or (QFH_JUR_3);

    if cbm_byPNetEn.Checked=True    then dwLoMask := dwLoMask or (QFH_ANET_EN);
    if cbm_byMPNetEn.Checked=True   then dwLoMask := dwLoMask or (QFH_AMNET_EN);
    if cbm_byPNetU.Checked=True     then dwLoMask := dwLoMask or (QFH_ANET_U);
    if cbm_byPNetI.Checked=True     then dwLoMask := dwLoMask or (QFH_ANET_I);
    if cbm_byPNetFi.Checked=True    then dwLoMask := dwLoMask or (QFH_ANET_FI);
    if cbm_byPNetCosFi.Checked=True then dwLoMask := dwLoMask or (QFH_ANET_CFI);
    if cbm_byPNetF.Checked=True     then dwLoMask := dwLoMask or (QFH_ANET_F);
    if cbm_byPNetP.Checked=True     then dwLoMask := dwLoMask or (QFH_ANET_P);
    if cbm_byPNetQ.Checked=True     then dwLoMask := dwLoMask or (QFH_ANET_Q);

    if cbRecalc.Checked=True        then dwLoMask := dwLoMask or QFH_RECALC_ABOID;

    ldtFTime  := dtFTime.DateTime;
    ldtETime  := dtETime.DateTime;
    nAID      := m_pTRI.PAID;
    nVMID     := m_pTRI.PVID;
    if m_pTRI.PVID=65535 then nVMID := -1;
    if cbAllAbon.Checked=True then nAID:=-1;
    m_nBoxQry := mL3FHModule.FindAbonHoles(nAID,nVMID,ldtETime,ldtFTime,dwLoMask);
    advStatus.Panels.Items[0].Text := 'Поиск завершен.';
    advStatus.Panels.Items[1].Text := 'Период : c ' + DateToStr(ldtETime)+' по '+DateToStr(ldtFTime);
    advStatus.Panels.Items[2].Text := 'Сформированых запросов:'+IntToStr(m_nBoxQry);
end;


procedure TTDataFinder.DoHalfTime(Sender:TObject);
Var
    dlBoxQry    : Double;
    dlCurBoxQry : Double;
    nCount : Integer;
Begin
    if m_blState=True then
    Begin
     nCount      := FCHECK(BOX_LOAD);
     dlBoxQry    := m_nBoxQry;
     dlCurBoxQry := nCount;
     pbm_sBTIProgress.Position :=100-trunc(100*dlCurBoxQry/dlBoxQry);
     if (FCHECK(BOX_LOAD))=0 then
     Begin
      pbm_sBTIProgress.Position :=100;
      m_blState      := False;
      FTimer.Enabled := False;
      m_nDataFinder  := False;
     End;
     advStatus.Panels.Items[2].Text := 'Обработано '+IntToStr(m_nBoxQry-nCount)+' из '+IntToStr(m_nBoxQry)+' запросов';
    End;
End;
procedure TTDataFinder.OnStopFind;
Var
    FSVStatus : Byte;
    nCMD      : Byte;
Begin
    advStatus.Panels.Items[0].Text := 'Загрузка данных завершена.';
    {
    if cbRecalc.Checked=True then
    Begin
     GetStatus(FSVStatus,nCMD);
     m_ngRCL.OnSetReCalc(m_pTRI.PAID,-1,nCMD,RCL_CALCL2 or RCL_CALCL3,dtFTime.DateTime, dtETime.DateTime);
    End;
    }
End;
procedure TTDataFinder.GetStatus(var FSVStatus,nCMD:Byte);
Begin
    if cbm_nPriDay.Checked=True then
    Begin
     nCMD      := QRY_ENERGY_DAY_EP;
     FSVStatus := SV_ARCH_ST;
    End;
    if cbm_nPriMonth.Checked=True then
    Begin
     nCMD      := QRY_ENERGY_MON_EP;
     FSVStatus := SV_ARCH_ST;
    End;
    if cbm_nPri30.Checked=True then
    Begin
     nCMD      := QRY_SRES_ENR_EP;
     FSVStatus := SV_GRPH_ST;
    End;
    if cbm_nNakDay.Checked=True then
    Begin
     nCMD      := QRY_NAK_EN_DAY_EP;
     FSVStatus := SV_ARCH_ST;
    End;
    if cbm_nNakMonth.Checked=True then
    Begin
     nCMD      := QRY_NAK_EN_MONTH_EP;
     FSVStatus := SV_ARCH_ST;
    End;
End;
procedure TTDataFinder.bEnablEvClick(Sender: TObject);
Var
    nTime : Integer;
begin
    bClearEvClick(Sender);
    OnFindHoles(Sender);

    if ((FCHECK(BOX_LOAD))<>0)and(m_blState=False) then
    Begin
     m_nDataFinder  := True;
     m_blState      := True;
     FTimer.Enabled := True;
     if cbRecalc.Checked=True then nTime := 2 else nTime := 4;
     if MessageDlg('Загрузка отсутствующих данных займет ~'+IntToStr(m_nBoxQry*nTime)+'сек. Выполнить ?',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      mL3FHModule.Go;
      advStatus.Panels.Items[0].Text := 'Загрузка данных.Ожидайте.';
     End;
    End else MessageDlg('Отсутствующих данных не обнаружено.',mtWarning,[mbOk,mbCancel],0)
end;
procedure TTDataFinder.bDisablEvClick(Sender: TObject);
Var
    pDS : CMessageData;
begin
    if m_nStateLr=0 then Begin MessageDlg('Функция временно не доступна.Ожидайте.',mtWarning,[mbOk,mbCancel],0); exit; End;
    if MessageDlg('Остановить выполнение операции?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
     FFREE(BOX_LOAD);
     m_blState     := False;
     m_nCF.SchedPause;
     FillChar(pDS,sizeof(pDS),0);
     pDS.m_swData4 := MTR_LOCAL;
     pDS.m_swData3 := 0;
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_DISC_POLL_REQ,pDS);
     SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL1_REQ,pDS);
    End;
end;
procedure TTDataFinder.bClearEvClick(Sender: TObject);
begin
     FFREE(BOX_LOAD);
     m_blState      := False;
     m_nCF.SchedPause;
     pbm_sBTIProgress.Position :=0;
     FTimer.Enabled := False;
     m_nDataFinder  := False;
     advStatus.Panels.Items[1].Text := 'Период : c ' + DateToStr(dtETime.DateTime)+' по '+DateToStr(dtFTime.DateTime);
     advStatus.Panels.Items[2].Text := 'Сформированых запросов:'+IntToStr(0);
end;
{
if cbm_byCurrent.Checked=True then dwLoMask := dwLoMask or (dwOne shl 5);
    if cbm_bySumEn.Checked=True   then dwLoMask := dwLoMask or (dwOne shl 6);
    if cbm_byMAP.Checked=True     then dwLoMask := dwLoMask or (dwOne shl 7);
    if cbm_byMRAP.Checked=True    then dwLoMask := dwLoMask or (dwOne shl 8);
    if cbm_byU.Checked=True       then dwLoMask := dwLoMask or (dwOne shl 9);
    if cbm_byI.Checked=True       then dwLoMask := dwLoMask or (dwOne shl 10);
    if cbm_byFreq.Checked=True    then dwLoMask := dwLoMask or (dwOne shl 11);
}

procedure TTDataFinder.OnClickCurr(Sender: TObject);
begin
    if cbm_byCurrent.Checked=True then
    Begin
     cbm_bySumEn.Enabled        := True;
     cbm_byMAP.Enabled  := True;
     cbm_byMRAP.Enabled := True;
     cbm_byU.Enabled    := True;
     cbm_byI.Enabled    := True;
     cbm_byFreq.Enabled := True;
     cbm_byCosFi.Enabled := True;
    End else
    if cbm_byCurrent.Checked=False then
    Begin
     cbm_bySumEn.Enabled        := False;
     cbm_byMAP.Enabled  := False;
     cbm_byMRAP.Enabled := False;
     cbm_byU.Enabled    := False;
     cbm_byI.Enabled    := False;
     cbm_byFreq.Enabled := False;
     cbm_byCosFi.Enabled := False;
    End;
end;

procedure TTDataFinder.OnClickEvents(Sender: TObject);
begin
    //cbm_byJEn
    if cbm_byJEn.Checked=True then
    Begin
     cbm_byJ0.Enabled := True;
     cbm_byJ1.Enabled := True;
     cbm_byJ2.Enabled := True;
     cbm_byJ3.Enabled := True;
    End else
    if cbm_byJEn.Checked=False then
    Begin
     cbm_byJ0.Enabled := False;
     cbm_byJ1.Enabled := False;
     cbm_byJ2.Enabled := False;
     cbm_byJ3.Enabled := False;
    End;
end;

procedure TTDataFinder.OnClickAEN(Sender: TObject);
begin
    if cbm_nArchEN.Checked=True then
    Begin
     cbm_nPriDay.Enabled   := True;
     cbm_nPriMonth.Enabled := True;
     cbm_nPri30.Enabled    := True;
     cbm_nNakDay.Enabled   := True;
     cbm_nNakMonth.Enabled := True;
    End else
    if cbm_nArchEN.Checked=False then
    Begin
     cbm_nPriDay.Enabled   := False;
     cbm_nPriMonth.Enabled := False;
     cbm_nPri30.Enabled    := False;
     cbm_nNakDay.Enabled   := False;
     cbm_nNakMonth.Enabled := False;
    End;
end;
procedure TTDataFinder.OnClickANetEN(Sender: TObject);
begin
    if cbm_byPNetEn.Checked=True then
    Begin
     cbm_byMPNetEn.Enabled:= True;
     cbm_byPNetU.Enabled  := True;
     cbm_byPNetI.Enabled  := True;
     cbm_byPNetFi.Enabled := True;
     cbm_byPNetCosFi.Enabled := True;
     cbm_byPNetF.Enabled  := True;
     cbm_byPNetP.Enabled  := True;
     cbm_byPNetQ.Enabled  := True;
    End else
    if cbm_byPNetEn.Checked=False then
    Begin
     cbm_byMPNetEn.Enabled:= False;
     cbm_byPNetU.Enabled  := False;
     cbm_byPNetI.Enabled  := False;
     cbm_byPNetFi.Enabled := False;
     cbm_byPNetCosFi.Enabled := False;
     cbm_byPNetF.Enabled  := False;
     cbm_byPNetP.Enabled  := False;
     cbm_byPNetQ.Enabled  := False;
    End;
end;

end.
