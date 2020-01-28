unit frmQueryModule;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, utlDB, utlConst, utltypes, ImgList, Menus,
  AdvMenus, checklst, AdvGlowButton, AdvToolBar;

type
  TNodeDataQM = class
    IDGr  : integer;  // собственно ID объекта
    Code  : byte;     // код узла SD_5XXXX см. ниже
    Enable: Integer;
    param : Integer;
  end;


  TFrameQueryModule = class(TFrame)
    Panel: TPanel;
    TreeView: TTreeView;
    ImageListQwery: TImageList;
    AdvPopupMenu: TAdvPopupMenu;
    mnuStopQwery: TMenuItem;
    mnuExecSetClust: TMenuItem;
    mnuAddAllCls: TMenuItem;
    mnuDelAllCls: TMenuItem;
    btnStop: TAdvGlowButton;
    procedure TreeViewClick(Sender: TObject);
    procedure TreeViewDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TreeViewDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TreeViewMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mnuStopQweryClick(Sender: TObject);
    procedure mnuExecSetClustClick(Sender: TObject);
    procedure mnuAddAllClsClick(Sender: TObject);
    procedure mnuDelAllClsClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
  private
    { Private declarations }
    mouseXY     : TPoint;
    function GetExtParam(QGID : Integer; var LB:TCheckListBox):Boolean;
    procedure OnLoadInParamDrop(VMID, PQGD : integer);
    function addQueryGroupParam(pTable:QGPARAM):Integer;
    function GetCommandsTable(nChannel:Integer;var pTable:CCOMMANDS):Boolean;    
    function GetSWVMID(SWMID : integer): integer;
    procedure createParam(qgID,cmdID:Integer);
  public
    NodeDataQM : TNodeDataQM;
    procedure Activate(ID  : Integer);
    procedure DeActivate;
    procedure ClearQueryModule;
    { Public declarations }
  end;

implementation

uses knsl2fqwerymdl, knsl5module, knsl2treehandler, frmTreeDataModule,
     fLogFile, fLogTypeCommand;

{$R *.DFM}

{ TFrameQueryModule }

procedure TFrameQueryModule.Activate(ID  : Integer);
var strSQL : string;
    Node   : TTreeNode;
    zNode  : TTreeNode;
    pNode  : TTreeNode;
    s      : string;
    nCount : Integer;
    i      : Integer;
begin
  ClearQueryModule;
  strSQL := 'SELECT QG.ID, QG.NAME, QGP.PARAM, QG.ENABLE, QM.M_SNAME ' +
            'FROM QGPARAM QGP, QM_PARAMS QM, QUERYGROUP QG ' +
            'WHERE QGP.PARAM = QM.M_SWTYPE ' +
            '  AND QGP.QGID = ' + IntToStr(ID) + ' ' +
            '  AND QG.ID = ' + IntToStr(ID) + ' ' +
            'ORDER BY QGP.PARAM';
  if utlDB.DBase.OpenQry(strSQL,nCount)=True then begin
    NodeDataQM :=TNodeDataQM.Create;
    NodeDataQM.IDGr := ID;
    NodeDataQM.Code := SD_QRYGR;
    NodeDataQM.Enable := utlDB.DBase.IBQuery.FieldByName('ENABLE').AsInteger;
    s := utlDB.DBase.IBQuery.FieldByName('NAME').AsString;
    Node:=TreeView.Items.AddObject(nil,s,NodeDataQM);
    Node.ImageIndex:=11; Node.SelectedIndex:=11;

    NodeDataQM :=TNodeDataQM.Create;
    NodeDataQM.IDGr := ID;
    NodeDataQM.Code := SD_QRYTP;
    NodeDataQM.Enable := utlDB.DBase.IBQuery.FieldByName('ENABLE').AsInteger;
    s := 'Задачи';
    zNode:=TreeView.Items.AddChildObject(Node,s,NodeDataQM);
    zNode.ImageIndex:=13; zNode.SelectedIndex:=13;

    for i := 0 to nCount-1 do begin
      NodeDataQM :=TNodeDataQM.Create;
      NodeDataQM.IDGr := ID;
      NodeDataQM.Code := SD_QRY01+i;
      NodeDataQM.Enable := utlDB.DBase.IBQuery.FieldByName('ENABLE').AsInteger;
      NodeDataQM.Param := utlDB.DBase.IBQuery.FieldByName('PARAM').AsInteger;
      s := utlDB.DBase.IBQuery.FieldByName('M_SNAME').AsString;
      pNode:=TreeView.Items.AddChildObject(zNode,s,NodeDataQM);
      pNode.ImageIndex:=3; pNode.SelectedIndex:=3;
      utlDB.DBase.IBQuery.Next;
    end;

    NodeDataQM :=TNodeDataQM.Create;
    NodeDataQM.IDGr := ID;
    NodeDataQM.Code := SD_QRYQO;
    NodeDataQM.Enable := utlDB.DBase.IBQuery.FieldByName('ENABLE').AsInteger;
    s := 'Объекты опроса';
    zNode:=TreeView.Items.AddChildObject(Node,s,NodeDataQM);
    zNode.ImageIndex:=12; zNode.SelectedIndex:=12;
  end;
  TreeView.FullExpand;
end;


procedure TFrameQueryModule.ClearQueryModule;
var i : Integer;
    Node : TTreeNode;       
begin
  try
    for i := 0 to TreeView.Items.Count-1 do begin
      Node := TreeView.Items[i];
      NodeDataQM := Node.Data;
      FreeAndNil(NodeDataQM);
    end;
    TreeView.Items.Clear;
  except
    on E:Exception do
      with lcERRInaccessibleValue do                 // BO 29.07.19
        LogFile.AddEventStringGroup(GRP,EVNT,IDCurrentUser,now, E.Message);
  end;
end;


procedure TFrameQueryModule.DeActivate;
begin
  ClearQueryModule;
end;

procedure TFrameQueryModule.TreeViewClick(Sender: TObject);
var Node : TTreeNode;
begin
//  TKnsForm.m_nQsFrame.ClearUnloadButton;
  Node := TreeView.Selected;
  NodeDataQM := Node.Data;
  case NodeDataQM.Code of
    SD_QRYGR : begin
      // Сама группа, вывести окно для неё
      TKnsForm.m_nQsFrame.advSrvPager.ActivePageIndex := 0;
      TKnsForm.m_nQsFrame.loadInQueryPannelID(NodeDataQM.IDGr, TreeView.Selected.Text, NodeDataQM.Enable);
      TKnsForm.m_nQsFrame.advSrvPager.AdvPages[0].TabVisible:=true;
      TKnsForm.m_nQsFrame.advSrvPager.AdvPages[1].TabVisible:=false;
      TKnsForm.m_nQsFrame.advSrvPager.AdvPages[2].TabVisible:=false;
    end;
    SD_QRYTP : begin
      // uncnow
    end;
    SD_QRY01, SD_QRY02, SD_QRY03, SD_QRY04, SD_QRY05, SD_QRY06,
    SD_QRY07, SD_QRY08, SD_QRY09, SD_QRY10 : begin
      // windows
      // 1-е значение
      TKnsForm.m_nQsFrame.advSrvPager.AdvPages[0].TabVisible:=false;
      TKnsForm.m_nQsFrame.advSrvPager.AdvPages[1].TabVisible:=true;
      TKnsForm.m_nQsFrame.advSrvPager.AdvPages[2].TabVisible:=false;
      TKnsForm.m_nQsFrame.advSrvPager.ActivePageIndex := 1;
      TKnsForm.m_nQsFrame.chm_sbyVTEnable.Enabled := true;
      TKnsForm.m_nQsFrame.autoUnload.Enabled      := true;
      TKnsForm.m_nQsFrame.btUnloadStart.Enabled   := true;
      if NodeDataQM.param<>QRY_NAK_EN_MONTH_EP then Begin
        TreeView.Items.Item[TreeView.Selected.AbsoluteIndex].SelectedIndex:=2;
        TKnsForm.m_nQsFrame.chm_sbyVTEnable.Enabled := false;
        TKnsForm.m_nQsFrame.autoUnload.Enabled      := false;
        TKnsForm.m_nQsFrame.btUnloadStart.Enabled   := false;
      End;
      case NodeDataQM.param of
        QRY_ENERGY_SUM_EP   : TKnsForm.m_nQsFrame.VisableAny(0);
        QRY_NAK_EN_DAY_EP   : TKnsForm.m_nQsFrame.VisableAny(1);
        QRY_NAK_EN_MONTH_EP : TKnsForm.m_nQsFrame.VisableAny(2);
        QRY_DATA_TIME       : TKnsForm.m_nQsFrame.VisableAny(3);
        else TKnsForm.m_nQsFrame.VisableAny(99);
      end;
      // FTreeQweryData.Items.Item[FTreeQweryData.Selected.AbsoluteIndex].SelectedIndex:=2;
      TreeView.Items.Item[TreeView.Selected.AbsoluteIndex].SelectedIndex:=2;

      TKnsForm.m_nQsFrame.loadInQueryParamsID(NodeDataQM.IDGr, NodeDataQM.param);

    end;
    SD_QRYQO : begin
      TKnsForm.m_nQsFrame.advSrvPager.AdvPages[0].TabVisible:=false;
      TKnsForm.m_nQsFrame.advSrvPager.AdvPages[1].TabVisible:=false;
      TKnsForm.m_nQsFrame.advSrvPager.AdvPages[2].TabVisible:=true;
      TKnsForm.m_nQsFrame.advSrvPager.ActivePageIndex := 2;
      TKnsForm.m_nQsFrame.loadInQueryAbonsID(NodeDataQM.IDGr);
    end;
  end;
end;




procedure TFrameQueryModule.TreeViewDragDrop(Sender, Source: TObject; X,
  Y: Integer);
Var
  nDest,nSrc : TTreeNode;
  NodeData   : TNodeData;
  PMID       : Integer;
  pTbl : SQWERYVM;
begin
  nSrc := TKnsForm.frameTreeDataModule.TreeList.Selected;
  NodeData:= nSrc.Data;
  PMID := GetSWVMID(NodeData.ID);

  nDest := TreeView.GetNodeAt(X, Y);
  if nDest = Nil then exit;
  NodeDataQM := nDest.Data;
  case NodeDataQM.Code of
    SD_QRYGR, SD_QRY01, SD_QRY02, SD_QRY03, SD_QRY04, SD_QRY05, SD_QRY06,
    SD_QRY07, SD_QRY08, SD_QRY09, SD_QRY10 : begin
      OnLoadInParamDrop(PMID, NodeDataQM.IDGr);
    end;
    SD_QRYQO : begin
      TKnsForm.frameTreeDataModule.DragNDrop(NodeDataQM.IDGr);
    end;
  end;
end;

procedure TFrameQueryModule.OnLoadInParamDrop(VMID, PQGD : integer);
Var pTbl  : CCOMMANDS;
    node  : TTreeNode;
    i     : Integer;
Begin
  if GetCommandsTable(VMID ,pTbl) then
  Begin
   for i:=0 to pTbl.m_swAmCommand-1 do
   Begin
    if (pTbl.m_sCommand[i].m_swCmdID = QRY_AUTORIZATION) or (pTbl.m_sCommand[i].m_swCmdID = QRY_EXIT_COM) then continue;
    createParam(PQGD, pTbl.m_sCommand[i].m_swCmdID);
   End;
  End;
  ClearQueryModule;
  Activate(PQGD);
End;


procedure TFrameQueryModule.createParam(qgID,cmdID:Integer);
Var data : QGPARAM;
Begin
  data := QGPARAM.Create;
  data.id        := -1;
  data.QGID      := qgID;
  data.PARAM     := cmdID;
  data.DTBEGIN   := Now;
  data.DTEND     := Now;
  data.DTPERIOD  := Now;
  data.MONTHMASK := 0;
  data.ENABLE    := 0;
  data.DEEPFIND  := 0;
  data.PAUSE     := 0;
  data.FINDDATA  := 0;
  addQueryGroupParam(data);
End;


procedure TFrameQueryModule.TreeViewDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
  nNode : TTreeNode;
  Node  : TTreeNode;
  NodeData : TNodeData;
  pIND  : PCTI;
begin
  Accept := False;
  TKnsForm.m_nQsFrame.DragFromNewTL:=false;
  Node:=TKnsForm.frameTreeDataModule.TreeList.Selected;
  if Node <> nil then begin
    NodeData:=Node.Data;
    if (NodeData.Code = SD_ABONT) or (NodeData.Code = SD_REGIN) or (NodeData.Code = SD_RAYON) or
       (NodeData.Code = SD_TOWNS) or (NodeData.Code = SD_TPODS) or (NodeData.Code = SD_STRET) then begin
      Accept := True;
      TKnsForm.m_nQsFrame.DragFromNewTL:=true;
    end;
    if (NodeData.Code = SD_APNUM) then begin
      Accept := True;
      TKnsForm.m_nQsFrame.DragFromNewTL:=true;
    end;
  end;

end;

procedure TFrameQueryModule.TreeViewMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var p    : TPoint;
    Node : TTreeNode;
begin
  Node := TreeView.GetNodeAt(X, Y);
  if Node <> nil then Node.Selected := true;

  if Button <> mbRight then exit;

  p.x:=X; p.y:=Y;
  p:=TreeView.ClientToScreen(p);
  TreeViewClick(Sender);
  AdvPopupMenu.Popup(p.x, p.y);
  mouseXY.x := p.x;
  mouseXY.y := p.y;
end;

function TFrameQueryModule.GetExtParam(QGID : Integer; var LB:TCheckListBox):Boolean;
Var strSQL  : String;
    res     : Boolean;
    nCount  : Integer;
    i, k, h : Integer;
Begin
  res := False;
  strSQL := 'SELECT * FROM QM_PARAMS ' +
            'WHERE M_SWTYPE IN (1, 17, 21, 37, 59, 73)';
  if utlDB.DBase.OpenQry(strSQL,nCount)=True then Begin
    LB.Items.Clear;
    res := True;
    while not utlDB.DBase.IBQuery.Eof do Begin
      with utlDB.DBase.IBQuery do  Begin
        LB.Items.AddObject(FieldByName('M_SNAME').AsString,
           TObject(FieldByName('M_SWTYPE').AsInteger));
        Next;
      End;
    End;
  End;
  utlDB.DBase.IBQuery.Close;
  utlDB.DBase.IBQuery.SQL.Clear;
  strSQL := 'SELECT ID, PARAM FROM QGPARAM ' +
            'WHERE QGID = ' + IntToStr(QGID);
  if utlDB.DBase.OpenQry(strSQL,nCount)=True then Begin
    for i := 0 to utlDB.DBase.IBQuery.RecordCount-1 do Begin

      for k := 0 to LB.Items.Count-1 do begin
        h := Integer(LB.Items.Objects[k]);
        if utlDB.DBase.IBQuery.FieldByName('PARAM').AsInteger = h then begin
          LB.Checked[k] := True;
        end;
      end;
      utlDB.DBase.IBQuery.Next;
    End;
  End;
  utlDB.DBase.IBQuery.Close;
  Result := res;
  TKnsForm.m_nQsFrame.qgID := QGID;
  TKnsForm.m_nQsFrame._PQGD := QGID;
End;


procedure TFrameQueryModule.mnuStopQweryClick(Sender: TObject);
var Node : TTreeNode;
begin
  Node := TreeView.Selected;
  NodeDataQM := Node.Data;
  if MessageDlg('Остановить опрос кластера?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    TKnsForm.m_nQsFrame.SendQSComm(NodeDataQM.IDGr,-1,-1,-1,QS_STOP_SR);
end;

procedure TFrameQueryModule.mnuExecSetClustClick(Sender: TObject);
begin
  if MessageDlg('Применить настройки?',mtWarning,[mbOk,mbCancel],0)=mrOk then
    TKnsForm.m_nQsFrame.SendQSComm(-1,-1,-1,-1,QS_INIT_SR);
end;

procedure TFrameQueryModule.mnuAddAllClsClick(Sender: TObject);
var Node : TTreeNode;
    p    : TPoint;
begin
  Node := TreeView.Selected;
  NodeDataQM := Node.Data;

  p.x:=mouseXY.x; p.y:=mouseXY.y;
 // p:=TreeView.ClientToScreen(p);
  ScreenToClient(p);

  TKnsForm.m_nQsFrame.ExtractListBox.Left := mouseXY.x-250;  // temporary
  TKnsForm.m_nQsFrame.ExtractListBox.Top  := mouseXY.y-90;   // temporary
  TKnsForm.m_nQsFrame.ExtractListBox.Height := 120;
  TKnsForm.m_nQsFrame.ExtractListBox.Width  := 300;
  TKnsForm.m_nQsFrame.ExtractListBox.Visible := True;

  TKnsForm.m_nQsFrame.ExtractBitBtn.Left := 0;
  TKnsForm.m_nQsFrame.ExtractBitBtn.Width := 300-2;
  TKnsForm.m_nQsFrame.ExtractBitBtn.Top  := TKnsForm.m_nQsFrame.ExtractListBox.Height -25 -2;

  TKnsForm.m_nQsFrame.qgID := NodeDataQM.IDGr;
  TKnsForm.m_nQsFrame._PQGD := NodeDataQM.IDGr;
  GetExtParam(NodeDataQM.IDGr, TKnsForm.m_nQsFrame.ExtractListBox);
end;

procedure TFrameQueryModule.mnuDelAllClsClick(Sender: TObject);
var Node : TTreeNode;
    strSQL : String;
begin
  Node := TreeView.Selected;
  NodeDataQM := Node.Data;
  if MessageDlg('Удалить задачи из группы ?',mtWarning,[mbOk,mbCancel],0)=mrOk then Begin
    if(NodeDataQM.IDGr<>-1) then Begin
        strSQL := 'DELETE FROM QGPARAM where QGID='+IntToStr(NodeDataQM.IDGr);
        utlDB.DBase.ExecQry(strSQL);
        ClearQueryModule;
        Activate(NodeDataQM.IDGr);
        TKnsForm.m_nQsFrame.SendQSComm(QS_INIT_SR,NodeDataQM.IDGr,-1);
    End;
  End;
end;

// ***********************************
// SQL для получения дополнительных данных (вероятно временно)
// ***********************************
function TFrameQueryModule.GetSWVMID(SWMID : integer): integer;
var strSQL     : string;
    nCount     : integer;
begin
  Result := -1;
  strSQL:='SELECT M_SWVMID FROM SL3VMETERTAG WHERE M_SWMID = ' + intToStr(SWMID); // Виртуальный счетчик
  if utlDB.DBase.OpenQry(strSQL,nCount) = True then begin
    Result:=utlDB.DBase.IBQuery.FieldByName('M_SWVMID').AsInteger;
  end;
end;


function TFrameQueryModule.GetCommandsTable(nChannel:Integer;var pTable:CCOMMANDS):Boolean;
Var
    i : Integer;
    strSQL   : String;
    res      : Boolean;
    nCount   : Integer;
Begin
  res := False;
  strSQL := 'SELECT s0.*,s1.M_SNAME FROM CCOMMAND as s0,QM_PARAMS as s1'+
  ' WHERE s0.m_swMID = '+IntToStr(nChannel)+
  ' AND s0.m_swCmdID = s1.m_swtype'+
  ' ORDER BY s0.m_swCmdID';
  if utlDB.DBase.OpenQry(strSQL,nCount) = True then Begin
   i:=0; res := True;
   pTable.m_swAmCommand := nCount;
   SetLength(pTable.m_sCommand,nCount);
   while not utlDB.DBase.IBQuery.Eof do Begin
   with utlDB.DBase.IBQuery, pTable.m_sCommand[i] do  Begin
    m_swID      := FieldByName('m_swID').AsInteger;
    m_swMID     := FieldByName('m_swMID').AsInteger;
    m_swCmdID   := FieldByName('m_swCmdID').AsInteger;
    m_swChannel := FieldByName('m_swChannel').AsString;
    m_swSpecc0  := FieldByName('m_swSpecc0').AsInteger;
    m_swSpecc1  := FieldByName('m_swSpecc1').AsInteger;
    m_swSpecc2  := FieldByName('m_swSpecc2').AsInteger;
    m_sbyEnable := FieldByName('m_sbyEnable').AsInteger;
    m_snDataType:= FieldByName('m_snDataType').AsInteger;
    m_swCommandNm := FieldByName('M_SNAME').AsString;
    Next;
    Inc(i);
    End;
   End;
  End;
  utlDB.DBase.IBQuery.Close;
  Result := res;
End;

function TFrameQueryModule.addQueryGroupParam(pTable:QGPARAM):Integer;
Var strSQL   : String;
    nCount   : Integer;
    id       : Integer;
    strMatch : String;
    keyField : String;
    keyData  : String;
Begin
  id := -1;
  if(pTable.id=-1) then
    strMatch := 'matching (QGID,PARAM)'
  else Begin
    keyField := 'id,';
    keyData  := IntToStr(pTable.id)+',';
  End;
  with pTable do Begin
  strSQL := 'UPDATE OR INSERT INTO QGPARAM'+
            '('+keyField+'QGID,PARAM,DTBEGIN,DTEND,DTPERIOD,'+
            'DAYMASK,MONTHMASK,ENABLE,DEEPFIND,PAUSE,FINDDATA,UNDEEPFIND,UNPATH,UNENABLE,ISRUNSTATUS,RUNSTATUS,ERRORPERCENT, TIMETOSTOP)'+
            ' VALUES('+keyData+
            IntToStr(QGID)+ ','+
            IntToStr(PARAM)+ ','+
            ''''+DateTimeToStr(DTBEGIN)+''''+','+
            ''''+DateTimeToStr(DTEND)+''''+','+
            ''''+DateTimeToStr(DTPERIOD)+''''+','+
            IntToStr(DAYMASK)+ ','+
            IntToStr(MONTHMASK)+ ','+
            IntToStr(ENABLE)+ ','+
            IntToStr(DEEPFIND)+ ','+
            IntToStr(PAUSE)+ ','+
            IntToStr(FINDDATA)+ ','+
            IntToStr(UNDEEPFIND)+ ','+
            ''''+UNPATH+''''+','+
            IntToStr(UNENABLE)+','+
            IntToStr(ISRUNSTATUS)+','+
            ''''+RUNSTATUS+''''+','+
            FloatToStr(ERRORPERCENT)+ ','+
            ''''+DateTimeToStr(TIMETOSTOP)+'''' + ') '+strMatch;
  End;
  utlDB.DBase.ExecQry(strSQL);
  Result := 1;
End;

procedure TFrameQueryModule.btnStopClick(Sender: TObject);
begin
  if MessageDlg('Остановить операции по всем группам ?',mtWarning,[mbOk,mbCancel],0)=mrOk then Begin
    with lcCEStopOperationsForAllGroups do                 // BO 20.11.18
      LogFile.AddEventStringGroup(GRP,EVNT, IDCurrentUser, now, TKnsForm.m_nQsFrame.qgParamName);
    TKnsForm.m_nQsFrame.SendQSData(QS_STOP_SR, -1, TKnsForm.m_nQsFrame.qgParamID,
               TKnsForm.m_nQsFrame.mdtBegin.DateTime, TKnsForm.m_nQsFrame.mdtEnd.DateTime);
  End;
end;

end.
