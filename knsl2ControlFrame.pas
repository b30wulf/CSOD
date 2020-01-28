{*******************************************************************************
 *  Модуль "Управление устройством"
 *  Ukrop
 *  22.12.2011
 ******************************************************************************}

unit knsl2ControlFrame;
{ DONE 5 -oUkrop -cNEW : Модуль "Управление устройством" }
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, AdvGroupBox, AdvOfficeButtons, AdvToolBar, ExtCtrls,
  AdvPanel, Grids, BaseGrid, AdvGrid, paramlst, ImgList, AdvToolBarStylers,
  paramtreeview, AdvAppStyler,

  utldatabase, utltypes, utlconst, utlbox, knsl3EventBox, knsl5config,
  knsl5tracer;

type
  TControlFrame = class(TForm)
    v_ap1: TAdvPanel;
    Label7: TLabel;
    v_TBImageList: TImageList;
    v_PanelStyler: TAdvPanelStyler;
    v_TBStyler: TAdvToolBarOfficeStyler;
    v_ap0: TAdvPanel;
    v_ToolBar: TAdvToolBar;
    AdvToolBarButton4: TAdvToolBarButton;
    v_atbMode: TAdvToolBarButton;
    AdvToolBarButton6: TAdvToolBarButton;
    v_ControlCMDS: TAdvStringGrid;
    v_Styler: TAdvFormStyler;
    v_lState: TLabel;
    procedure v_ControlCMDSGetEditorType(Sender: TObject; ACol,
      ARow: Integer; var AEditor: TEditorType);
    procedure v_ControlCMDSGetCellColor(Sender: TObject; ARow,
      ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure v_atbModeClick(Sender: TObject);
    procedure v_ControlCMDSCheckBoxClick(Sender: TObject; ACol,
      ARow: Integer; State: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AdvToolBarButton4Click(Sender: TObject);
    procedure SendRemCrcQry(nPort:Byte;var pDS:CMessageData);
    function  GetRealPort(nPort:Integer):Integer;
  private
    m_BasePath      : String;
//    m_VaList        : Array[0..10] of String[20];
    m_ControlParams : CTRLCOMMANDS;
    m_sTblL1        : SL1INITITAG;
  public
    m_ViewIndex    : byte;
    m_ABOID       : Integer;
    m_Index       : Integer;             // Индитефикатор параметра
    m_MasterIndex : Integer;             // Индитефикатор виртуального счетчика
    m_MID         : Integer;             // Физический счетчик
    m_VMID        : Integer;             // НИФизический счетчик
    m_PRID        : Integer;
    m_TID         : Integer;
    m_MTID        : Integer;             // Тип счетчика;
    m_SVStatus    : Integer;
    m_CLStatus    : Integer;
    m_Location    : Integer;
    function  InitModule() : Boolean;
  end;

var
  m_IndexT : Integer;

implementation

{$R *.DFM}

function TControlFrame.InitModule() : Boolean;
var
  l_i : Integer;
begin
  m_nCF.m_nSetColor.PControlStyler := @v_Styler;
  m_nCF.m_nSetColor.SetAllStyle(m_nCF.StyleForm.ItemIndex);

   m_pDB.GetL1Table(m_sTblL1);
  m_BasePath := ExtractFilePath(Application.ExeName) + '\\Settings\\Control\\';
  v_ControlCMDS.RowCount   := 1;
  v_ControlCMDS.FixedRows  := 1;
  v_ControlCMDS.Enabled := False;

  v_lState.Caption := 'Комманды управления отсутствуют!';

  // загрузить список комманд управления для устройства
  if m_pDB.GetCommandsTableCTRL(m_MID, m_ControlParams) = true then
  begin
   try
    v_ControlCMDS.RowCount := m_ControlParams.m_swAmCommand + 1;
    v_ControlCMDS.FixedRows:= 1;
    v_lState.Caption := '';
    v_ControlCMDS.Enabled := True;

    for l_i:=0 to m_ControlParams.m_swAmCommand-1 do
    begin
      v_ControlCMDS.Cells[0, l_i+1] := IntToStr(l_i + 1);
      v_ControlCMDS.AddCheckBox(1, l_i+1, false, false);
      v_ControlCMDS.Cells[1, l_i+1] := ' Нет';
      v_ControlCMDS.Cells[2, l_i+1] := m_ControlParams.m_sCommand[l_i].m_sParamName;
      v_ControlCMDS.Cells[3, l_i+1] := IntToStr(m_ControlParams.m_sCommand[l_i].m_swSpecc0);
      v_ControlCMDS.Cells[4, l_i+1] := '';//'1: ' + IntToStr(m_ControlParams.m_sCommand[l_i].m_swSpecc1) + ', 2: '+IntToStr(m_ControlParams.m_sCommand[l_i].m_swSpecc2);

    end;
   except
      v_lState.Caption := 'Комманды управления отсутствуют!';
   end;
  end else
  begin
    v_lState.Caption := 'Комманды управления отсутствуют!';
  end;
  Result := True;
end;

procedure TControlFrame.v_ControlCMDSGetEditorType(Sender: TObject; ACol, ARow: Integer; var AEditor: TEditorType);
begin
  if (ARow = 0) OR not(goEditing in v_ControlCMDS.Options) then
    AEditor := edNone
  else
  case ACol of
    1 :
    Begin
      AEditor := edCheckBox;
    End;
    0,2,4 :
    Begin
      AEditor := edNone;
    End;
    3 :
    Begin
      AEditor := edComboList;
      try
        if (ARow <= m_ControlParams.m_swAmCommand) then
          v_ControlCMDS.Combobox.Items.LoadFromFile(m_BasePath + IntToStr(m_ControlParams.m_sCommand[ARow-1].m_swCmdID) + '.st');
      except
        AEditor := edNone;
      end;
    End;
  end;

end;

procedure TControlFrame.v_ControlCMDSGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
    with (Sender AS TAdvStringGrid)  do Begin
    if (ARow=0)or(ACol=0) then
    Begin
     AFont.Size  := 8;
     AFont.Style := [fsBold];
     AFont.Color := clBlack;
    End;
    if (ARow>0) and (ACol>0)then
     Begin
      if ACol>0 then
      Begin
       AFont.Color :=  m_blGridDataFontColor;//clAqua;
       AFont.Size  :=  m_blGridDataFontSize;
       AFont.Name  :=  m_blGridDataFontName;
      End;
     End;
    End;

end;

procedure TControlFrame.v_atbModeClick(Sender: TObject);
begin
  try
  if (goEditing in v_ControlCMDS.Options) then // editing
  begin
    v_atbMode.ImageIndex := 1;
    v_atbMode.Hint       := 'Отображение';
    v_ControlCMDS.Options := v_ControlCMDS.Options + [goRangeSelect, goRowSelect] - [goEditing, goDrawFocusSelected];
  end
  else if (v_ControlCMDS.RowCount > 1) then
  begin
    v_atbMode.ImageIndex := 2;
    v_atbMode.Hint       := 'Редактирование';
    v_ControlCMDS.Options := v_ControlCMDS.Options - [goRangeSelect, goRowSelect] + [goEditing, goDrawFocusSelected];
  End;
  except
  end;
end;

procedure TControlFrame.v_ControlCMDSCheckBoxClick(Sender: TObject; ACol, ARow: Integer; State: Boolean);
begin
  if (ARow > 0) AND (ARow <= m_ControlParams.m_swAmCommand) then
  begin
    if State = true then
      v_ControlCMDS.Cells[ACol,ARow] := ' Да'
    else
      v_ControlCMDS.Cells[ACol,ARow] := ' Нет';
  end;
end;

procedure TControlFrame.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     Action := caFree;
     m_nCF.m_nSetColor.PControlStyler := nil;
end;

procedure TControlFrame.AdvToolBarButton4Click(Sender: TObject);
var
  l_i : Integer;
  l_CBState : Boolean;
  l_StateID : DWORD;


//  szDT : Integer;
  pDS  : CMessageData;
  l_StrL : TStringList;
begin
  if (MessageDlg('Выполнить выбранные команды управления?',mtConfirmation,[mbYes,mbNo],0) = mrYes) then
  begin
  
  l_StrL := TStringList.Create();
  
  for l_i:=0 to m_ControlParams.m_swAmCommand-1 do
  begin
    v_ControlCMDS.GetCheckBoxState(1, l_i + 1, l_CBState);
    if (l_CBState) then
    begin
      pDS.m_swData0 := m_VMID;
      pDS.m_swData1 := m_ControlParams.m_sCommand[l_i].m_swCmdID;
      pDS.m_swData2 := m_MID;
      pDS.m_swData3 := GetRealPort(m_PRID);
      if (m_blIsLocal=True)and(m_blIsSlave=True) then m_Location := MTR_LOCAL;
      if (m_blIsLocal=False)then m_Location := MTR_REMOTE else m_Location := MTR_LOCAL;
      pDS.m_swData4 := m_Location;
      l_StrL.LoadFromFile(m_BasePath + IntToStr(m_ControlParams.m_sCommand[l_i].m_swCmdID) + '.st');
      l_StateID := l_StrL.IndexOf(v_ControlCMDS.Cells[3, l_i+1]);
      Move(l_StateID, pDS.m_sbyInfo,4);
      if (m_blIsRemCrc=True)or(m_blIsRemEco=True)or(m_blIsRemC12=True) then Begin SendRemCrcQry(m_PRID,pDS);exit; End;
      SendMsgData(BOX_L3_LME,0,DIR_LHTOLM3,LME_STOP_POLL1_REQ,pDS);
      SendMsgData(BOX_L3_LME,m_MasterIndex,DIR_LHTOLM3,LME_STOP_POLL_REQ,pDS);
      SendMsgData(BOX_L3_LME,m_MID,DIR_LHTOLM3,QL_DATA_CTRL_REQ,pDS);  { ukrop ctrl step 1}
    end;
  end;
  end;
end;


procedure TControlFrame.SendRemCrcQry(nPort:Byte;var pDS:CMessageData);
Var
    m_nTxMsg : CHMessage;
    wCRC:Word;
Begin
    m_PRID := 0;
    FillChar(m_nTxMsg.m_sbyInfo[0],80,0);
    move(pDS.m_swData0,m_nTxMsg.m_sbyInfo[6], 4);
    move(pDS.m_swData1,m_nTxMsg.m_sbyInfo[10],4);
    move(pDS.m_swData2,m_nTxMsg.m_sbyInfo[14],4);
    move(pDS.m_swData3,m_nTxMsg.m_sbyInfo[18],4);
    move(pDS.m_sbyInfo[0],m_nTxMsg.m_sbyInfo[26],sizeof(TDateTime)*2);
    if m_blIsRemCrc=True then
    Begin
     CreateMsgCrcRem(m_nTxMsg.m_sbyInfo[0], (26+16+1)+4, $FF02);
     CreateMSGHeadCrcRem(m_PRID,m_nTxMsg, (26+16+1)+4);
    End else
    if m_blIsRemEco=True then
    Begin
     m_nTxMsg.m_sbyInfo[0] := 1;
     m_nTxMsg.m_sbyInfo[1] := 202;
     wCRC := CRCEco(m_nTxMsg.m_sbyInfo[0], 26+16);
     m_nTxMsg.m_sbyInfo[26+16] := Lo(wCRC);
     m_nTxMsg.m_sbyInfo[26+16+1] := Hi(wCRC);
     CreateMSGHeadCrcRem(m_PRID,m_nTxMsg, (26+16+2));
    End;
    if m_blIsRemC12=True then
    Begin
     m_nTxMsg.m_sbyInfo[0] := 1;
     m_nTxMsg.m_sbyInfo[1] := $FA;
     m_nTxMsg.m_sbyInfo[2] := 202;
     CRC_C12(m_nTxMsg.m_sbyInfo[0], 26+16+2);
     CreateMSGHeadCrcRem(m_PRID,m_nTxMsg, (26+16+2));
    End;
    TraceM(2,m_nTxMsg.m_sbyIntID,'(__)CCRRM::>Out DRQ:',@m_nTxMsg);
    FPUT(BOX_L1, @m_nTxMsg);
End;


function TControlFrame.GetRealPort(nPort:Integer):Integer;
Var
    i : Integer;
Begin
    Result := nPort;
    for i:=0 to m_sTblL1.Count-1 do
    Begin
     with m_sTblL1.Items[i] do
     Begin
      if m_sbyPortID=nPort then
      Begin
       Result := m_sbyPortID;
       if m_sblReaddres=1 then Result := m_swAddres;
       exit;
      End;
     End;
    End;
End;
end.
