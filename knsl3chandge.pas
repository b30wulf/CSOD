unit knsl3chandge;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  AdvProgressBar, Grids, BaseGrid, AdvGrid, StdCtrls, AdvGlowButton,
  AdvToolBar, ImgList, AdvToolBarStylers, AdvPanel, AdvOfficeStatusBar,
  AdvOfficeStatusBarStylers, ExtCtrls, AdvSplitter, AdvAppStyler,knsl3cheditor,knsl3chdteditor,knsl5config,utltypes,
  utlbox,utldatabase,utlconst,utlmtimer, ComCtrls, AdvProgr;

type
  TTMeterChandge = class(TForm)
    ChandgeStyler: TAdvFormStyler;
    splHorSplitt: TAdvSplitter;
    AdvPanel1: TAdvPanel;
    AdvPanel3: TAdvPanel;
    AdvToolBar1: TAdvToolBar;
    AdvPanel4: TAdvPanel;
    AdvPanel5: TAdvPanel;
    AdvToolBar2: TAdvToolBar;
    AdvPanel6: TAdvPanel;
    sbChandge: TAdvOfficeStatusBar;
    AdvOfficeStatusBarOfficeStyler1: TAdvOfficeStatusBarOfficeStyler;
    AdvPanelStyler1: TAdvPanelStyler;
    AdvToolBarOfficeStyler1: TAdvToolBarOfficeStyler;
    imgEditPannel: TImageList;
    AdvSplitter1: TAdvSplitter;
    AdvPanel7: TAdvPanel;
    AdvPanel9: TAdvPanel;
    ImageList1: TImageList;
    advQryNewB: TAdvGlowButton;
    advCalcButt: TAdvGlowButton;
    advQryOldB: TAdvGlowButton;
    sgGrid: TAdvStringGrid;
    sgCGrid: TAdvStringGrid;
    Label3: TLabel;
    ImageList2: TImageList;
    advGrvBAddDesc: TAdvGlowButton;
    pbm_sBTIProgress: TAdvProgress;
    advActivateOf: TAdvGlowButton;
    advNewSetConf: TAdvGlowButton;
    advNewSetReq: TAdvGlowButton;
    AdvGlowButton1: TAdvGlowButton;
    advSetChandge: TAdvGlowMenuButton;
    AdvGlowMenuButton2: TAdvGlowMenuButton;
    AdvGlowMenuButton3: TAdvGlowMenuButton;
    AdvGlowMenuButton4: TAdvGlowMenuButton;
    AdvGlowMenuButton5: TAdvGlowMenuButton;
    AdvGlowMenuButton6: TAdvGlowMenuButton;
    AdvGlowMenuButton7: TAdvGlowMenuButton;
    AdvGlowMenuButton1: TAdvGlowMenuButton;
    AdvGlowMenuButton8: TAdvGlowMenuButton;
    AdvGlowMenuButton9: TAdvGlowMenuButton;
    AdvGlowMenuButton10: TAdvGlowMenuButton;
    AdvGlowMenuButton11: TAdvGlowMenuButton;
    AdvGlowMenuButton12: TAdvGlowMenuButton;
    advSetChandgeDt: TAdvGlowMenuButton;
    Label1: TLabel;
    advLoadOldDB: TAdvGlowButton;
    advLoadNewDB: TAdvGlowButton;
    procedure OnFormCreate(Sender: TObject);
    procedure OnFormResize(Sender: TObject);
    procedure OnSetEditChng(Sender: TObject);
    procedure OnSaveGrid(Sender: TObject);
    procedure OnSetGrid(Sender: TObject);
    procedure OnAddRow(Sender: TObject);
    procedure OnCloneRow(Sender: TObject);
    procedure OnDelRow(Sender: TObject);
    procedure OnDelAllRow(Sender: TObject);
    procedure OnGetType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure OnClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure OnClose(Sender: TObject; var Action: TCloseAction);
    procedure OnCreateDescriptor(Sender: TObject);
    procedure OnReadOldParam(Sender: TObject);
    procedure OnReadNewParam(Sender: TObject);
    procedure OnSaveDTGrid(Sender: TObject);
    procedure OnSetDTGrid(Sender: TObject);
    procedure OnAddDtRow(Sender: TObject);
    procedure OnCloneDtRow(Sender: TObject);
    procedure OnDelDtRow(Sender: TObject);
    procedure OnDelAllDtRow(Sender: TObject);
    procedure OnSetEditDtChng(Sender: TObject);
    procedure OnGetDtType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure OnClickDtCell(Sender: TObject; ARow, ACol: Integer);
    procedure OnStartCalc(Sender: TObject);
    procedure OnDActivateDesc(Sender: TObject);
    procedure OnGetDtColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure OnChGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure OnNewSetRequest(Sender: TObject);
    procedure OnNewSetConfirm(Sender: TObject);
    procedure OnStopProc(Sender: TObject);
    procedure advLoadOldDBClick(Sender: TObject);
    procedure advLoadNewDBClick(Sender: TObject);
  private
    { Private declarations }
    m_nCHED : CL3ChEditor;
    m_pTRI  : CTreeIndex;
    m_nWQryTimer : CTimer;
    m_nCmdIndex  : Integer;
    m_nCmdID     : Integer;
    m_nNewOld    : Integer;
    timer        : TTimer;
    queryTime    : Integer;
    procedure OnInitVmeter;
    procedure SetEditGrid(var blState:Boolean;var btButt:TAdvToolBarButton;var sgGrid:TAdvStringGrid;blIsRow:Boolean);
    procedure SetEditGridGl(var blState:Boolean;var btButt:TAdvGlowMenuButton;var sgGrid:TAdvStringGrid;blIsRow:Boolean);
    function  QryParam(nParam:Integer):Integer;
    procedure CauseQryParam;
    procedure SetGrid;
    function  NextCommand:Integer;
    procedure DoneCalc;
    procedure SendQSDataEx(nCommand,snAID,snMid,nCMDID:Integer;sdtBegin,sdtEnd:TDateTime);
    procedure SendQSData(nCommand,snSRVID,nCMDID:Integer;sdtBegin,sdtEnd:TDateTime);
    procedure OnTimeElapsed(Sender:TObject);dynamic;
  public
    { Public declarations }
    m_blHandQry  : Boolean;
    procedure Run;
    procedure OnOpen(pTRI:CTreeIndex);
    procedure EventHandler(var pMsg:CMessage);

  end;

var
  TMeterChandge: TTMeterChandge;
const
    CNG_WAIT_TIME = 60;
implementation

{$R *.DFM}

procedure TTMeterChandge.OnFormCreate(Sender: TObject);
begin
     m_nCF.m_nSetColor.PChandgeAT     := @sgGrid;
     m_nCF.m_nSetColor.PChandgeDT     := @sgCGrid;
     m_nCF.m_nSetColor.PChandgeStyler := @ChandgeStyler;

     m_nCHED                := CL3ChEditor.Create;
     m_nCHED.PsgGrid        := @sgGrid;
     m_nCHED.Init;
     m_nCHED.PChild         := CL3ChdtEditor.Create;
     m_nCHED.PChild.PsgGrid := @sgCGrid;

     m_nCHED.PChild.Init;

     m_nWQryTimer := CTimer.Create;
     m_nWQryTimer.SetTimer(DIR_L3TOL3,DL_LDONE_MTR_TMOF_IND,0,0,BOX_L3);
     m_blHandQry := False;

     if timer=nil then
     Begin
      timer          := TTimer.Create(Nil);
      timer.Interval := 10*1000;
      timer.Enabled  := false;
      timer.OnTimer  := OnTimeElapsed;
     End;
end;
procedure TTMeterChandge.OnOpen(pTRI:CTreeIndex);
Begin
     try
     Move(pTRI,m_pTRI,sizeof(m_pTRI));
     m_nCHED.PTRI        := @m_pTRI;
     m_nCHED.PChild.PTRI := @m_pTRI;
     m_nCHED.PMIndex     := m_pTRI.PVID;
     m_nCHED.ExecSetGrid;
     //if sgGrid.Cells[2,1]<>'' then m_nCHED.PIndex := StrToInt(sgGrid.Cells[2,1]) else m_nCHED.PChild.PsgGrid.ClearNormalCells;
     advGrvBAddDesc.ImageIndex := 0;
     advQryOldB.ImageIndex     := 0;
     advNewSetReq.ImageIndex   := 0;
     advQryNewB.ImageIndex     := 0;
     advCalcButt.ImageIndex    := 0;
     advNewSetConf.ImageIndex  := 0;
     advActivateOf.ImageIndex  := 0;
     pbm_sBTIProgress.Position := 0;
     except
     
     end
End;

procedure TTMeterChandge.OnFormResize(Sender: TObject);
begin
     if m_nCHED<>Nil then m_nCHED.OnFormResize;
end;

procedure TTMeterChandge.OnSetEditChng(Sender: TObject);
begin
    SetEditGridGl(m_blCL3ChngEditor,advSetChandge,sgGrid,True);
    m_nCHED.SetEdit;
//    if m_blCL3ChngEditor=True  then m_pDB.FixUspdEvent(0,3,EVS_CHANDR_ED_ON) else
//    if m_blCL3ChngEditor=False then m_pDB.FixUspdEvent(0,3,EVS_CHANDR_ED_OF);
end;
procedure TTMeterChandge.SetEditGridGl(var blState:Boolean;var btButt:TAdvGlowMenuButton;var sgGrid:TAdvStringGrid;blIsRow:Boolean);
Begin
 if blState=False then //Open
    Begin
     btButt.ImageIndex := 7;
     btButt.Caption := 'Редактирование';
     blState           := True;
     sgGrid.Options    := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goDrawFocusSelected,goColSizing,goEditing];
    End else
    if blState=True then //Close
    Begin
     btButt.ImageIndex := 6;
     btButt.Caption := 'Отображение';
     blState           := False;
     if blIsRow=True  then sgGrid.Options := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goDrawFocusSelected,goColSizing,goRowSelect{goEditing}] else
     if blIsRow=False then sgGrid.Options    := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goDrawFocusSelected,goColSizing];
    End;
End;

procedure TTMeterChandge.SetEditGrid(var blState:Boolean;var btButt:TAdvToolBarButton;var sgGrid:TAdvStringGrid;blIsRow:Boolean);
begin
    if blState=False then //Open
    Begin
     btButt.ImageIndex := 7;
     btButt.Hint       := 'Редактирование';
     blState           := True;
     sgGrid.Options    := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goDrawFocusSelected,goColSizing,goEditing];
    End else
    if blState=True then //Close
    Begin
     btButt.ImageIndex := 6;
     btButt.Hint       := 'Отображение';
     blState           := False;
     if blIsRow=True  then sgGrid.Options := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goDrawFocusSelected,goColSizing,goRowSelect{goEditing}] else
     if blIsRow=False then sgGrid.Options    := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goDrawFocusSelected,goColSizing];
    End;
end;

procedure TTMeterChandge.OnSaveGrid(Sender: TObject);
begin
    if m_blCL3ChngEditor=True Then
    m_nCHED.OnSaveGrid;
end;

procedure TTMeterChandge.OnSetGrid(Sender: TObject);
begin
    if m_blCL3ChngEditor=True Then
    m_nCHED.OnSetGrid;
end;

procedure TTMeterChandge.OnAddRow(Sender: TObject);
begin
    if m_blCL3ChngEditor=True Then
    m_nCHED.OnAddRow;
end;

procedure TTMeterChandge.OnCloneRow(Sender: TObject);
begin
    if m_blCL3ChngEditor=True Then
    m_nCHED.OnCloneRow;
end;

procedure TTMeterChandge.OnDelRow(Sender: TObject);
begin
    if m_blCL3ChngEditor=True Then
    Begin
     m_nCHED.OnDelRow;
     OnInitVmeter;
    End;
end;

procedure TTMeterChandge.OnDelAllRow(Sender: TObject);
begin
    if m_blCL3ChngEditor=True Then
    Begin
     OnDActivateDesc(self);
     m_nCHED.OnDelAllRow;
    End;
end;

procedure TTMeterChandge.OnGetType(Sender: TObject; ACol, ARow: Integer;
  var AEditor: TEditorType);
begin
    m_nCHED.OnGetType(Sender,ACol, ARow,AEditor);
end;

procedure TTMeterChandge.OnClickCell(Sender: TObject; ARow, ACol: Integer);
begin
    m_nCHED.OnClickGrid(Sender,ARow,ACol);
end;

procedure TTMeterChandge.OnClose(Sender: TObject;
  var Action: TCloseAction);
begin
    if timer<>nil then
    Begin
      timer.Enabled := false;
      timer.Destroy;
      timer := nil;
    End;
    m_blCL3ChngEditor := True;
    SetEditGridGl(m_blCL3ChngEditor,advSetChandge,sgGrid,True);
    Action := caFree;
end;
function TTMeterChandge.QryParam(nParam:Integer):Integer;
Var
     szDT   : Integer;
     pDS    : CMessageData;
     dtTime : TDateTime;
begin
     Result := nParam;
     {if nParam=-1 then exit;
     szDT          := sizeof(TDateTime);
     pDS.m_swData0 := m_pTRI.PVID;
     pDS.m_swData1 := nParam;
     pDS.m_swData2 := m_pTRI.PMID;
     pDS.m_swData3 := m_pTRI.PPID;
     pDS.m_swData4 := 0;
     dtTime        := Now;
     Move(dtTime,pDS.m_sbyInfo[0]   ,szDT);
     Move(dtTime,pDS.m_sbyInfo[szDT],szDT);
     if m_blIsLocal=True  then Begin pDS.m_swData4 := MTR_LOCAL; End;
     if m_blIsLocal=False then Begin pDS.m_swData4 := MTR_REMOTE;End;
     case nParam of
          QRY_NAK_EN_DAY_EP,
          QRY_NAK_EN_MONTH_EP:
           Begin
            SendMsgData(BOX_L3_LME,m_pTRI.PVID,DIR_LHTOLM3,LME_STOP_POLL1_REQ,pDS);
            SendMsgData(BOX_L3_LME,m_pTRI.PMID,DIR_LHTOLM3,QL_DATA_GRAPH_REQ,pDS);
           End;
          QRY_ENERGY_SUM_EP  :
           Begin
            SendMsgData(BOX_L3_LME,m_pTRI.PVID,DIR_LHTOLM3,LME_STOP_POLL1_REQ,pDS);
            SendMsgData(BOX_L3_LME,m_pTRI.PMID,DIR_LHTOLM3,QL_QRY_PARAM_REQ,pDS);
           End;
     End;
     m_nWQryTimer.OnTimer(CNG_WAIT_TIME);}
     SendQSDataEx(QS_LOAD_ON,m_pTRI.PAID,m_pTRI.PMID,nParam,trunc(now),trunc(now));
end;
procedure TTMeterChandge.CauseQryParam;
Begin
     m_blHandQry := False;
     if m_nNewOld=0 then advQryOldB.ImageIndex := 4;
     if m_nNewOld=1 then advQryNewB.ImageIndex := 4;
     sbChandge.Panels.Items[0].Text := 'Информация со счетчика не получена!';
     if MessageDlg('Внимание!Показания не считаны. Использовать последние накопленные данные? ',mtWarning,[mbOk,mbCancel],0)=mrOk then
     Begin
      m_nCHED.OnSetDataGrid(QRY_ENERGY_SUM_EP,m_nNewOld);
      m_nCHED.ExecSelRowGrid;
      m_nCHED.OnSetDataGrid(QRY_NAK_EN_DAY_EP,m_nNewOld);
      m_nCHED.ExecSelRowGrid;
      m_nCHED.OnSetDataGrid(QRY_NAK_EN_MONTH_EP,m_nNewOld);
      m_nCHED.ExecSelRowGrid;
      if m_nNewOld=0 then advQryOldB.ImageIndex := 3;
      if m_nNewOld=1 then advQryNewB.ImageIndex := 3;
     End;
End;
procedure TTMeterChandge.DoneCalc;
Begin
     {if m_blHandQry=True then
     Begin
      SetGrid;
      m_nCmdID     := NextCommand;
      if m_nCmdID<>-1 then Begin QryParam(m_nCmdID);pbm_sBTIProgress.Position:=pbm_sBTIProgress.Position+20;end else
      Begin
       pbm_sBTIProgress.Position := 100;
       if m_nNewOld=0 then Begin advQryOldB.ImageIndex := 2;sbChandge.Panels.Items[0].Text := 'Информация со счетчика получена. Установите счетчик и выполните п.№3 для считывания показаний.';End;
       if m_nNewOld=1 then Begin advQryNewB.ImageIndex := 2;sbChandge.Panels.Items[0].Text := 'Информация со счетчика получена. Выполните п.№4 для расчета дельты коррекции.';End;
       m_nWQryTimer.OffTimer;
       m_blHandQry := False;
      End;
     End;}
     if m_blHandQry=True then
     Begin
      m_nCHED.OnSetDataGrid(QRY_ENERGY_SUM_EP,m_nNewOld);
      m_nCHED.ExecSelRowGrid;
      m_nCHED.OnSetDataGrid(QRY_NAK_EN_DAY_EP,m_nNewOld);
      m_nCHED.ExecSelRowGrid;
      m_nCHED.OnSetDataGrid(QRY_NAK_EN_MONTH_EP,m_nNewOld);
      m_nCHED.ExecSelRowGrid;
      pbm_sBTIProgress.Position := 100;
      if m_nNewOld=0 then Begin advQryOldB.ImageIndex := 2;sbChandge.Panels.Items[0].Text := 'Информация со счетчика получена. Установите счетчик и выполните п.№3 для считывания показаний.';End;
      if m_nNewOld=1 then Begin advQryNewB.ImageIndex := 2;sbChandge.Panels.Items[0].Text := 'Информация со счетчика получена. Выполните п.№4 для расчета дельты коррекции.';End;
      m_blHandQry := False;
     End;
End;
function TTMeterChandge.NextCommand:Integer;
Begin
     Result := QRY_NAK_EN_DAY_EP;
     case m_nCmdIndex of
          0 : Result:=QRY_ENERGY_SUM_EP;
          1 : Result:=QRY_NAK_EN_DAY_EP;
          2 : Result:=QRY_NAK_EN_MONTH_EP;
     else
              Result := -1;
     End;
     m_nCmdIndex := m_nCmdIndex + 1;
End;
procedure TTMeterChandge.EventHandler(var pMsg:CMessage);
Begin
     case pMsg.m_sbyType of
          DL_LDONE_MTR_TMOF_IND: CauseQryParam;
          DL_LDONE_MTR_CALC_IND: DoneCalc;
     End;
End;
procedure TTMeterChandge.SendQSData(nCommand,snSRVID,nCMDID:Integer;sdtBegin,sdtEnd:TDateTime);
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

procedure TTMeterChandge.SendQSDataEx(nCommand,snAID,snMid,nCMDID:Integer;sdtBegin,sdtEnd:TDateTime);
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
procedure TTMeterChandge.SetGrid;
Begin
     m_nCHED.OnSetDataGrid(m_nCmdID,m_nNewOld);
     m_nCHED.ExecSelRowGrid;
End;
procedure TTMeterChandge.Run;
Begin
     if m_nWQryTimer<>Nil then m_nWQryTimer.RunTimer;
End;


procedure TTMeterChandge.OnSaveDTGrid(Sender: TObject);
begin
     if m_blCL3ChngDtEditor=True Then
     m_nCHED.PChild.OnSaveGrid;
end;

procedure TTMeterChandge.OnSetDTGrid(Sender: TObject);
begin
     if m_blCL3ChngDtEditor=True Then
     m_nCHED.PChild.OnSetGrid;
end;

procedure TTMeterChandge.OnAddDtRow(Sender: TObject);
begin
     if m_blCL3ChngDtEditor=True Then
     m_nCHED.PChild.OnAddRow;
end;

procedure TTMeterChandge.OnCloneDtRow(Sender: TObject);
begin
     if m_blCL3ChngDtEditor=True Then
     m_nCHED.PChild.OnCloneRow;
end;

procedure TTMeterChandge.OnDelDtRow(Sender: TObject);
begin
     if m_blCL3ChngDtEditor=True Then
     m_nCHED.PChild.OnDelRow;
end;

procedure TTMeterChandge.OnDelAllDtRow(Sender: TObject);
begin
     if m_blCL3ChngDtEditor=True Then
     m_nCHED.PChild.OnDelAllRow;
end;

procedure TTMeterChandge.OnSetEditDtChng(Sender: TObject);
begin
    SetEditGridGl(m_blCL3ChngDtEditor,advSetChandgeDt,sgCGrid,True);
    m_nCHED.PChild.SetEdit;
//    if m_blCL3ChngEditor=True  then m_pDB.FixUspdEvent(0,3,EVS_CHANDR_ED_ON) else
//    if m_blCL3ChngEditor=False then m_pDB.FixUspdEvent(0,3,EVS_CHANDR_ED_OF);
end;

procedure TTMeterChandge.OnGetDtType(Sender: TObject; ACol, ARow: Integer;
  var AEditor: TEditorType);
begin
    m_nCHED.PChild.OnGetType(Sender,ACol, ARow,AEditor);
end;

procedure TTMeterChandge.OnClickDtCell(Sender: TObject; ARow,
  ACol: Integer);
begin
    m_nCHED.PChild.OnClickGrid(Sender,ARow,ACol);
end;
procedure TTMeterChandge.OnInitVmeter;
Var
    pDS : CMessageData;
Begin
    pDS.m_swData0 := m_pTRI.PVID;
    if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
    if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
    SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,QL_INIT_VMET_REQ,pDS);
End;
procedure TTMeterChandge.OnCreateDescriptor(Sender: TObject);
begin
    //OnDActivateDesc(self);
    m_blCL3ChngEditor := False;
    OnSetEditChng(self);
     pbm_sBTIProgress.Position := 30;
     advGrvBAddDesc.ImageIndex := 1;
    OnAddRow(self);
     pbm_sBTIProgress.Position := 60;
     advGrvBAddDesc.ImageIndex := 3;
    OnSaveGrid(self);
    OnSetEditChng(self);
    m_nCHED.ExecSelRowGrid;
     pbm_sBTIProgress.Position := 100;
     advGrvBAddDesc.ImageIndex := 2;
     sbChandge.Panels.Items[0].Text := 'Дескриптор создан успешно. Выполните пункт №2 для заполнения таблицы коррекции показаниями заменяемого счетчика.';
end;
procedure TTMeterChandge.OnReadOldParam(Sender: TObject);
begin
     m_blHandQry := True;
     m_nCmdIndex := 0;
     m_nNewOld   := 1;
     queryTime   := 14;
     timer.Enabled  := true;
     //m_nCmdID    := NextCommand;
     m_nCmdID    := QRY_ENERGY_SUM_EP;
     QryParam(QRY_ENERGY_SUM_EP);
     QryParam(QRY_NAK_EN_DAY_EP);
     QryParam(QRY_NAK_EN_MONTH_EP);
     pbm_sBTIProgress.Position := 0;
     advQryOldB.ImageIndex     := 1;
     sbChandge.Panels.Items[0].Text := 'Запрос показаний из заменяемого счетчика.';
     m_nNewOld := 0;
end;
procedure TTMeterChandge.OnNewSetRequest(Sender: TObject);
begin
     pbm_sBTIProgress.Position := 50;
     advNewSetReq.ImageIndex   := 1;
     if m_nCHED.OnSaveNewL2Param=True then
     Begin
      pbm_sBTIProgress.Position := 100;
      advNewSetReq.ImageIndex   := 2;
      sbChandge.Panels.Items[0].Text := 'Запись настроек для установленного счетчика выполнена.';
     End else advNewSetReq.ImageIndex := 3;
end;
procedure TTMeterChandge.OnReadNewParam(Sender: TObject);
begin
     m_blHandQry := True;
     m_nCmdIndex := 0;
     m_nNewOld   := 1;
     //m_nCmdID    := NextCommand;
     queryTime   := 14;
     timer.Enabled  := true;
     //QryParam(m_nCmdID);
     QryParam(QRY_ENERGY_SUM_EP);
     QryParam(QRY_NAK_EN_DAY_EP);
     QryParam(QRY_NAK_EN_MONTH_EP);
     pbm_sBTIProgress.Position := 0;
     advQryNewB.ImageIndex     := 1;
     sbChandge.Panels.Items[0].Text := 'Запрос показаний из установленного счетчика.';
end;
procedure TTMeterChandge.OnStartCalc(Sender: TObject);
begin
    m_blCL3ChngDtEditor := False;
    OnSetEditDtChng(self);
     pbm_sBTIProgress.Position := 30;
     advCalcButt.ImageIndex    := 0;
     sbChandge.Panels.Items[0].Text := 'Начало вычислений.';
     m_nCHED.PChild.OnCalc;
     pbm_sBTIProgress.Position := 60;
     advCalcButt.ImageIndex    := 1;
     sbChandge.Panels.Items[0].Text := 'Вычисления завершены.';
     OnSaveDTGrid(self);
     pbm_sBTIProgress.Position := 100;
     advCalcButt.ImageIndex    := 2;
     sbChandge.Panels.Items[0].Text := 'Дескриптор замены готов к использованию. Выполните п.№5 для применнения дескриптора в расчетах.';
    OnSetEditDtChng(self);
end;
procedure TTMeterChandge.OnNewSetConfirm(Sender: TObject);
begin
    pbm_sBTIProgress.Position := 50;
    advNewSetConf.ImageIndex  := 1;
    if MessageDlg('Активировать дескриптор замены?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
     sbChandge.Panels.Items[0].Text := 'Начало инициализации.';
     m_nCHED.OnActivateDesc(True);
     pbm_sBTIProgress.Position := 100;
     advNewSetConf.ImageIndex  := 2;
     OnInitVmeter;
     sbChandge.Panels.Items[0].Text := 'Дескриптор активирован...';
    End else advNewSetConf.ImageIndex := 3;
end;
procedure TTMeterChandge.OnDActivateDesc(Sender: TObject);
begin
    pbm_sBTIProgress.Position := 50;
    advActivateOf.ImageIndex  := 1;
    if MessageDlg('Деактивировать дескриптор замены?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    Begin
     sbChandge.Panels.Items[0].Text := 'Начало инициализации.';
     m_nCHED.OnActivateDesc(False);
     pbm_sBTIProgress.Position := 100;
     advActivateOf.ImageIndex  := 2;
     OnInitVmeter;
     sbChandge.Panels.Items[0].Text := 'Дескриптор деактивирован...';
    End else advActivateOf.ImageIndex  := 3;
end;
procedure TTMeterChandge.OnTimeElapsed(Sender:TObject);
Begin
    //loadInQueryAbons(m_pRPDS.trTRI);
    if assigned(timer) then
    Begin
      if queryTime>0 then
      Begin
       dec(queryTime);
       timer.Interval := 10*1000;
       pbm_sBTIProgress.Position := pbm_sBTIProgress.Position + 6;
      End else
      Begin
       timer.Enabled  := false;
       pbm_sBTIProgress.Position := 100;
       queryTime := 14;
       DoneCalc;
      End;
    End;
End;

procedure TTMeterChandge.OnGetDtColor(Sender: TObject; ARow, ACol: Integer;
  AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
    m_nCHED.PChild.OnChannelGetCellColor(Sender,ARow,ACol,AState,ABrush,AFont);
end;

procedure TTMeterChandge.OnChGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
   m_nCHED.OnChannelGetCellColor(Sender,ARow,ACol,AState,ABrush,AFont);
end;

procedure TTMeterChandge.OnStopProc(Sender: TObject);
Var
    pDS : CMessageData;
begin
    FillChar(pDS,sizeof(pDS),0);
    pbm_sBTIProgress.Position := 0;
    if m_blIsLocal=True  then pDS.m_swData4 := MTR_LOCAL;
    if m_blIsLocal=False then pDS.m_swData4 := MTR_REMOTE;
    SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_DISC_POLL_REQ,pDS);
    SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL1_REQ,pDS);
end;

procedure TTMeterChandge.advLoadOldDBClick(Sender: TObject);
begin
    m_nCHED.OnSetDataGrid(QRY_ENERGY_SUM_EP,0);
    m_nCHED.ExecSelRowGrid;
    m_nCHED.OnSetDataGrid(QRY_NAK_EN_DAY_EP,0);
    m_nCHED.ExecSelRowGrid;
    m_nCHED.OnSetDataGrid(QRY_NAK_EN_MONTH_EP,0);
    m_nCHED.ExecSelRowGrid;
end;

procedure TTMeterChandge.advLoadNewDBClick(Sender: TObject);
begin
    m_nCHED.OnSetDataGrid(QRY_ENERGY_SUM_EP,1);
    m_nCHED.ExecSelRowGrid;
    m_nCHED.OnSetDataGrid(QRY_NAK_EN_DAY_EP,1);
    m_nCHED.ExecSelRowGrid;
    m_nCHED.OnSetDataGrid(QRY_NAK_EN_MONTH_EP,1);
    m_nCHED.ExecSelRowGrid;
end;

end.
