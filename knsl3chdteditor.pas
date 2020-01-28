unit knsl3chdteditor;
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,Messages,
  Graphics, Controls, Forms, Dialogs, Spin,
  Grids, BaseGrid, AdvGrid,utlbox,utlconst,utldatabase,knsl1module,
  knsl2editor,knsl2treeloader,knsl5tracer,knsl5config, knsl2BTIInit;
type
    CL3ChdtEditor = class
    Private
     FTreeModule    : PTTreeView;
     m_byTrState    : Byte;
     m_byTrEditMode : Byte;
     m_nRowIndex    : Integer;
     m_nAmRecords   : Integer;
     m_nPageIndex   : Integer;
     m_nIndex       : Integer;
     m_nType        : Integer;
     m_nMIndex      : Integer;
     m_nIDIndex     : Integer;
     m_strCurrentDir: String;
     FsgGrid        : PTAdvStringGrid;
     FsgCGrid       : PTAdvStringGrid;
     FChild         : CL2Editor;
     FTreeLoader    : PCTreeLoader;
     m_pParams      : QM_PARAMS;
     FTRI           : PCTreeIndex;
     m_sKI          : Double;
     m_sKU          : Double;
     m_nPR          : Integer;
     constructor Create;
     function  FindRow(str:String):Integer;
     procedure ViewChild(nIndex:Integer);
     procedure OnExecute(Sender: TObject);
     procedure ExecEditData;
     procedure ExecAddData;
     procedure ExecDelData;

     procedure AddRecordToGrid(nIndex:Integer;pTbl:PSL3CHANDT);
     function  SetIndex(nIndex : Integer):Integer;
     function  GenIndex:Integer;
     function  GenIndexSv:Integer;
     procedure FreeAllIndex;
     procedure FreeIndex(nIndex : Integer);
     function  FindFreeRow(nIndex:Integer):Integer;
     procedure GetGridRecord(var pTbl:SL3CHANDT);
     procedure InitCombo;
    Public
     procedure Init;
     procedure ExecSelRowGrid;
     procedure OnFormResize;
     procedure OnChannelGetCellColor(Sender: TObject; ARow,
               ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
     procedure OnGetType(Sender: TObject; ACol, ARow: Integer;
               var AEditor: TEditorType);
     procedure OnClickGrid(Sender: TObject; ARow, ACol: Integer);
     procedure SetDefaultRow(i:Integer);
     procedure ExecSetEditData(nIndex:Integer);
     procedure ExecInitLayer;
     procedure ExecSetTree;
     procedure ExecSetGrid;
     procedure OnCalc;
     procedure OnEditNode;
     procedure OnAddNode;
     procedure OnDeleteNode;
     procedure OnSaveGrid;
     procedure OnSetGrid;
     procedure OnSetDataGrid(nType:Integer);
     procedure OnInitLayer;
     procedure OnDelRow;
     procedure OnDelAllRow;
     procedure OnAddRow;
     procedure OnCloneRow;
     procedure SetEdit;
    Public
     property KI          :Double           read m_sKI        write m_sKI;
     property KU          :Double           read m_sKU        write m_sKU;
     property PR          :Integer          read m_nPR        write m_nPR;
     property PTRI        :PCTreeIndex      read FTRI         write FTRI;
     property PTreeModule :PTTreeView       read FTreeModule  write FTreeModule;
     property PsgGrid     :PTAdvStringGrid  read FsgGrid      write FsgGrid;
     property PsgCGrid    :PTAdvStringGrid  read FsgCGrid     write FsgCGrid;
     property PPageIndex  :Integer          read m_nPageIndex write m_nPageIndex;
     property PIndex      :Integer          read m_nIndex     write m_nIndex;
     property PMIndex     :Integer          read m_nMIndex    write m_nMIndex;
     property PChild      :CL2Editor        read FChild       write FChild;
     property PTreeLoader :PCTreeLoader     read FTreeLoader  write FTreeLoader;
    End;
implementation
constructor CL3ChdtEditor.Create;
Begin

End;
{
SL3CHANDGE = packed record
     m_swID      : Integer;
     m_swVMID    : Integer;
     m_swCHID    : Integer;
     m_dtTime    : TDateTime;
     m_swUID     : Integer;
     m_sfKU_0    : Double;
     m_sfKI_0    : Double;
     m_sfKU_1    : Double;
     m_sfKI_1    : Double;
     m_sbyEnable : Byte;
     Item        : SL3CHANDT;
    End;
SL3CHANDT = packed record
     m_swID      : Integer;
     m_swCHID    : Integer;
     m_swCNBID   : Integer;
     m_swCMDID   : Word;
     m_swTID     : Word;
     m_sTime     : TDateTime;
     m_sfValue   : Double;
    End;
}
procedure CL3ChdtEditor.Init;
Var
    i : Integer;
Begin
    m_strCurrentDir := ExtractFilePath(Application.ExeName) + '\\Settings\\';
    //for i:=0 to MAX_CHNG  do m_blChngIndex[i]  := True;
    m_nRowIndex  := -1;
    m_nPageIndex := 0;
    m_nIDIndex   := 1;
    m_nType      := 0;
    FsgGrid.ColCount    := 17;
    FsgGrid.RowCount    := 40;
    FsgGrid.Cells[0,0]  := '№/T';
    FsgGrid.Cells[1,0]  := 'DSID';
    FsgGrid.Cells[2,0]  := 'Считываемый параметр';
    FsgGrid.Cells[3,0]  := 'Время';
    FsgGrid.Cells[4,0]  := 'Тар.';
    FsgGrid.Cells[5,0]  := 'W+';
    FsgGrid.Cells[6,0]  := 'W-';
    FsgGrid.Cells[7,0]  := 'Q+';
    FsgGrid.Cells[8,0]  := 'Q-';
    FsgGrid.Cells[9,0]  := 'W"+';
    FsgGrid.Cells[10,0] := 'W"-';
    FsgGrid.Cells[11,0] := 'Q"+';
    FsgGrid.Cells[12,0] := 'Q"-';
    FsgGrid.Cells[13,0] := 'dW+';
    FsgGrid.Cells[14,0] := 'dW-';
    FsgGrid.Cells[15,0] := 'dQ+';
    FsgGrid.Cells[16,0] := 'dQ-';
    FsgGrid.ColWidths[0]:= 30;
    FsgGrid.ColWidths[1]:= 30;
    FsgGrid.ColWidths[2]:= 150;
    FsgGrid.ColWidths[3]:= 70;
    FsgGrid.ColWidths[4]:= 50;
    //ExecSetGrid;
    //FChild                := CL2Editor.Create;
    //FChild.PPageIndex     := 1;
End;

procedure CL3ChdtEditor.OnFormResize;
Var
    i : Integer;
Begin
    for i:=5 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i] := trunc((FsgGrid.Width-(30+150+70+50)-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1-4));
    //PChild.OnFormResize;
End;
procedure CL3ChdtEditor.SetEdit;
Var
    pTbl : SL3CHANDGES;
    i    : Integer;
Begin
    m_nRowIndex  := -1;
    //m_pDB.GetPrecision(FTRI.PVID,m_nPR);
    //FreeAllIndex;
    //if m_pDB.GetChandgeTable(PMIndex,pTbl)=True then for i:=0 to pTbl.Count-1 do SetIndex(pTbl.Items[i].m_swCHID);
End;
procedure CL3ChdtEditor.InitCombo;
Var
    i : Integer;
Begin
    if m_pDB.GetParamsTypeTable(m_nParams) then
    Begin
     FsgGrid.combobox.ItemHeight := 30;
     FsgGrid.combobox.Items.Clear;
     for i:=0 to m_nParams.Count-1 do
     FsgGrid.combobox.Items.Add(m_nParams.Items[i].m_sName);
    End;
End;
//Edit Add Del Request
procedure CL3ChdtEditor.OnEditNode;
begin
end;
procedure CL3ChdtEditor.OnAddNode;
begin
end;
procedure CL3ChdtEditor.OnDeleteNode;
Begin
End;
//Edit Add Del Execute
procedure CL3ChdtEditor.ExecSetEditData(nIndex:Integer);
Begin
End;
procedure CL3ChdtEditor.ExecEditData;
Begin
End;
procedure CL3ChdtEditor.ExecAddData;
Begin
End;
procedure CL3ChdtEditor.ExecDelData;
Begin
End;
procedure CL3ChdtEditor.ExecInitLayer;
Begin
    TraceL(1,0,'ExecInitLayer.');
    mL1Module.Init;
End;
//Tree Reload
procedure CL3ChdtEditor.ExecSetTree;
Begin
    TraceL(1,0,'ExecSetTree.');
    FTreeLoader.LoadTree;
End;
//Grid Routine
{
     function GetChandgeTable(nIndex:Integer;var pTable:SL3CHANDGES):Boolean;
     function AddChandgeTable(nIndex:Integer;var pTable:SL3CHANDGE):Boolean;
     function IsChandgeTable(var pTable:SL3CHANDGE):Boolean;
     function SetChandgeTable(var pTable:SL3CHANDGE):Boolean;
     function DelChandgeTable(nVMID,nIndex:Integer):Boolean;
     function AddChandgeDTTable(nVMID,nIndex:Integer):Boolean;
}
procedure CL3ChdtEditor.ExecSetGrid;
Var
    pTbl : SL3CHANDTS;
    i : Integer;
Begin
    FsgGrid.ClearNormalCells;
    if m_pDB.GetChandgeDTTable(PMIndex,pTbl)=True then
    Begin
     m_nAmRecords := pTbl.Count;
     FsgGrid.RowCount := pTbl.Count + 20;
     for i:=0 to pTbl.Count-1 do
     Begin
      SetIndex(pTbl.Items[i].m_swCHID);
      AddRecordToGrid(i,@pTbl.Items[i]);
     End;
     //ViewChild(m_nIndex);
    End;
End;
{
     m_sfWP0     : Double;
     m_sfWM0     : Double;
     m_sfQP0     : Double;
     m_sfQM0     : Double;
     m_sfWP1     : Double;
     m_sfWM1     : Double;
     m_sfQP1     : Double;
     m_sfQM1     : Double;
     m_sfDWP     : Double;
     m_sfDWM     : Double;
     m_sfDQP     : Double;
     m_sfDQM     : Double;
}
procedure CL3ChdtEditor.OnCalc;
Var
    pTbl  : SL3CHANDTS;
    i     : Integer;
Begin
    if m_pDB.GetChandgeDTTable(PMIndex,pTbl)=True then
    Begin

     for i:=0 to pTbl.Count-1 do
     Begin
      with pTbl.Items[i] do
      Begin
       m_sfDWP := RVLPr(m_sfWP0 - m_sfWP1,m_nPR);
       m_sfDWM := RVLPr(m_sfWM0 - m_sfWM1,m_nPR);
       m_sfDQP := RVLPr(m_sfQP0 - m_sfQP1,m_nPR);
       m_sfDQM := RVLPr(m_sfQM0 - m_sfQM1,m_nPR);
      End;
      AddRecordToGrid(i,@pTbl.Items[i]);
     End;
    End;
End;
procedure CL3ChdtEditor.AddRecordToGrid(nIndex:Integer;pTbl:PSL3CHANDT);
Var
   nY : Integer;
   nVisible : Integer;
Begin
    nY := nIndex+1;
    nVisible := round(FsgGrid.Height/21);
    if (nY-nVisible)>0  then FsgGrid.TopRow := nY-nVisible;
    with pTbl^ do Begin
     //FsgGrid.Cells[0,nY]  := IntToStr(nY);
     FsgGrid.Cells[0,nY]  := IntToStr(pTbl.m_swID);
     FsgGrid.Cells[1,nY]  := IntToStr(m_swCHID);
     FsgGrid.Cells[2,nY]  := m_nCommandList.Strings[m_swCMDID];
     FsgGrid.Cells[3,nY]  := DateTimeToStr(m_sTime);
     FsgGrid.Cells[4,nY]  := IntToStr(m_swTID);
     FsgGrid.Cells[5,nY]  := FloatToStr(m_sfWP0);
     FsgGrid.Cells[6,nY]  := FloatToStr(m_sfWM0);
     FsgGrid.Cells[7,nY]  := FloatToStr(m_sfQP0);
     FsgGrid.Cells[8,nY]  := FloatToStr(m_sfQM0);
     FsgGrid.Cells[9,nY]  := FloatToStr(m_sfWP1);
     FsgGrid.Cells[10,nY] := FloatToStr(m_sfWM1);
     FsgGrid.Cells[11,nY] := FloatToStr(m_sfQP1);
     FsgGrid.Cells[12,nY] := FloatToStr(m_sfQM1);
     FsgGrid.Cells[13,nY] := FloatToStr(m_sfDWP);
     FsgGrid.Cells[14,nY] := FloatToStr(m_sfDWM);
     FsgGrid.Cells[15,nY] := FloatToStr(m_sfDQP);
     FsgGrid.Cells[16,nY] := FloatToStr(m_sfDQM);
     {
     FsgGrid.Cells[5,nY]  := FloatToStr(RVLPr(m_sfWP0/(m_sKI*m_sKU),m_nPR));
     FsgGrid.Cells[6,nY]  := FloatToStr(RVLPr(m_sfWM0/(m_sKI*m_sKU),m_nPR));
     FsgGrid.Cells[7,nY]  := FloatToStr(RVLPr(m_sfQP0/(m_sKI*m_sKU),m_nPR));
     FsgGrid.Cells[8,nY]  := FloatToStr(RVLPr(m_sfQM0/(m_sKI*m_sKU),m_nPR));
     FsgGrid.Cells[9,nY]  := FloatToStr(RVLPr(m_sfWP1/(m_sKI*m_sKU),m_nPR));
     FsgGrid.Cells[10,nY] := FloatToStr(RVLPr(m_sfWM1/(m_sKI*m_sKU),m_nPR));
     FsgGrid.Cells[11,nY] := FloatToStr(RVLPr(m_sfQP1/(m_sKI*m_sKU),m_nPR));
     FsgGrid.Cells[12,nY] := FloatToStr(RVLPr(m_sfQM1/(m_sKI*m_sKU),m_nPR));
     FsgGrid.Cells[13,nY] := FloatToStr(RVLPr(m_sfDWP/(m_sKI*m_sKU),m_nPR));
     FsgGrid.Cells[14,nY] := FloatToStr(RVLPr(m_sfDWM/(m_sKI*m_sKU),m_nPR));
     FsgGrid.Cells[15,nY] := FloatToStr(RVLPr(m_sfDQP/(m_sKI*m_sKU),m_nPR));
     FsgGrid.Cells[16,nY] := FloatToStr(RVLPr(m_sfDQM/(m_sKI*m_sKU),m_nPR));
     }
    End;
End;
procedure CL3ChdtEditor.OnSetGrid;
Begin
    ExecSetGrid;
End;
procedure CL3ChdtEditor.OnSaveGrid;
Var
    i    : Integer;
    pTbl : SL3CHANDT;
Begin
    for i:=1 to FsgGrid.RowCount do
    Begin
     if FsgGrid.Cells[1,i]='' then break;
     pTbl.m_swID := i;
     GetGridRecord(pTbl);
     if m_pDB.AddChnDTTable(PMIndex,pTbl)=True then SetIndex(pTbl.m_swCHID);
    End;
    ExecSetGrid;
End;
{
    SL3CHANDT = packed record
     m_swID      : Integer;
     m_swCHID    : Integer;
     m_swCNBID   : Integer;
     m_swCMDID   : Word;
     m_swTID     : Word;
     m_sTime     : TDateTime;
     m_sfWP0     : Double;
     m_sfWM0     : Double;
     m_sfQP0     : Double;
     m_sfQM0     : Double;
     m_sfWP1     : Double;
     m_sfWM1     : Double;
     m_sfQP1     : Double;
     m_sfQM1     : Double;
     m_sfDWP     : Double;
     m_sfDWM     : Double;
     m_sfDQP     : Double;
     m_sfDQM     : Double;
    End;
}
procedure CL3ChdtEditor.GetGridRecord(var pTbl:SL3CHANDT);
Var
    i : Integer;
Begin
    i := pTbl.m_swID;
    with pTbl do Begin
     m_swID    := StrToInt(FsgGrid.Cells[0,i]);
     m_swCHID  := StrToInt(FsgGrid.Cells[1,i]);
     m_swCMDID := m_nCommandList.IndexOf(FsgGrid.Cells[2,i]);
     m_sTime   := StrToDateTime(FsgGrid.Cells[3,i]);
     m_swTID   := StrToInt(FsgGrid.Cells[4,i]);
     m_sfWP0   := StrToFloat(FsgGrid.Cells[5,i]);
     m_sfWM0   := StrToFloat(FsgGrid.Cells[6,i]);
     m_sfQP0   := StrToFloat(FsgGrid.Cells[7,i]);
     m_sfQM0   := StrToFloat(FsgGrid.Cells[8,i]);
     m_sfWP1   := StrToFloat(FsgGrid.Cells[9,i]);
     m_sfWM1   := StrToFloat(FsgGrid.Cells[10,i]);
     m_sfQP1   := StrToFloat(FsgGrid.Cells[11,i]);
     m_sfQM1   := StrToFloat(FsgGrid.Cells[12,i]);
     m_sfDWP   := StrToFloat(FsgGrid.Cells[13,i]);
     m_sfDWM   := StrToFloat(FsgGrid.Cells[14,i]);
     m_sfDQP   := StrToFloat(FsgGrid.Cells[15,i]);
     m_sfDQM   := StrToFloat(FsgGrid.Cells[16,i]);
    End;
End;
procedure CL3ChdtEditor.SetDefaultRow(i:Integer);
Var
    nIndex : Integer;
Begin
    //if FsgGrid.Cells[0,i]=''  then FsgGrid.Cells[0,i]  := '0';
    FsgGrid.Cells[0,i]  := '-1';
    if FsgGrid.Cells[1,i]=''  then FsgGrid.Cells[1,i]  := IntToStr(PMIndex);
    if FsgGrid.Cells[2,i]=''  then FsgGrid.Cells[2,i]  := m_nCommandList.Strings[QRY_NAK_EN_DAY_EP];
    if FsgGrid.Cells[3,i]=''  then FsgGrid.Cells[3,i]  := DateTimeToStr(Now);
    if FsgGrid.Cells[4,i]=''  then FsgGrid.Cells[4,i]  := '0';
    if FsgGrid.Cells[5,i]=''  then FsgGrid.Cells[5,i]  := '0.0';
    if FsgGrid.Cells[6,i]=''  then FsgGrid.Cells[6,i]  := '0.0';
    if FsgGrid.Cells[7,i]=''  then FsgGrid.Cells[7,i]  := '0.0';
    if FsgGrid.Cells[8,i]=''  then FsgGrid.Cells[8,i]  := '0.0';
    if FsgGrid.Cells[9,i]=''  then FsgGrid.Cells[9,i]  := '0.0';
    if FsgGrid.Cells[10,i]='' then FsgGrid.Cells[10,i] := '0.0';
    if FsgGrid.Cells[11,i]='' then FsgGrid.Cells[11,i] := '0.0';
    if FsgGrid.Cells[12,i]='' then FsgGrid.Cells[12,i] := '0.0';
    if FsgGrid.Cells[13,i]='' then FsgGrid.Cells[13,i] := '0.0';
    if FsgGrid.Cells[14,i]='' then FsgGrid.Cells[14,i] := '0.0';
    if FsgGrid.Cells[15,i]='' then FsgGrid.Cells[15,i] := '0.0';
    if FsgGrid.Cells[16,i]='' then FsgGrid.Cells[16,i] := '0.0';
End;
procedure CL3ChdtEditor.ExecSelRowGrid;
Begin
    FsgGrid.SelectRows(FindRow(IntToStr(m_nIndex)),1);
    FsgGrid.Refresh;
    ViewChild(m_nIndex);
End;
function CL3ChdtEditor.FindRow(str:String):Integer;
Var
   i : Integer;
Begin
   for i:=1 to FsgGrid.RowCount do if FsgGrid.Cells[m_nIDIndex,i]=str then
    Begin
     if (i-FsgGrid.VisibleRowCount)>0  then FsgGrid.TopRow := i-FsgGrid.VisibleRowCount+1 else FsgGrid.TopRow := 1;
     Result := i;
     exit;
    End;
    Result := 1;
End;
procedure CL3ChdtEditor.OnSetDataGrid(nType:Integer);
Begin
    m_nType := nType;
    ExecSelRowGrid;
End;
procedure CL3ChdtEditor.ViewChild(nIndex:Integer);
Begin
    if m_blCL3ChngDTEditor=False then
    if FChild<>Nil then
    Begin
     FChild.PMasterIndex := nIndex;
     FChild.PIndex       := m_nType;
     FChild.ExecSetGrid;
    End;
End;
function CL3ChdtEditor.FindFreeRow(nIndex:Integer):Integer;
Var
    i : Integer;
Begin
    for i:=1 to FsgGrid.RowCount-1 do if FsgGrid.Cells[nIndex,i]='' then
    Begin
     Result := i;
     exit;
    End;
    Result := 1;
End;
procedure CL3ChdtEditor.OnAddRow;
Var
    nIndex : Integer;
Begin
    if m_nRowIndex<>-1 then
    Begin
     SetDefaultRow(m_nRowIndex);
     SetIndex(StrToInt(FsgGrid.Cells[m_nIDIndex,m_nRowIndex]));
    End else
    Begin
     nIndex := FindFreeRow(3);
     SetDefaultRow(nIndex);
     SetIndex(StrToInt(FsgGrid.Cells[m_nIDIndex,nIndex]));
    End;
    //ExecSelRowGrid;
End;
procedure CL3ChdtEditor.OnCloneRow;
Var
    nIndex : Integer;
    pTbl   : SL3CHANDT;
Begin
    if m_nRowIndex<>-1 then
    if m_nRowIndex<=FindFreeRow(3)-1 then
    Begin
     pTbl.m_swID := m_nRowIndex;
     GetGridRecord(pTbl);
     pTbl.m_swCHID := PMIndex;
     pTbl.m_swID := -1;
     AddRecordToGrid(FindFreeRow(3)-1,@pTbl);
    End;
End;
procedure CL3ChdtEditor.OnDelRow;
Var
    nFind : Integer;
Begin
    if m_nAmRecords=FindFreeRow(3)-1 then
    Begin
     if m_nIndex<>-1 then
     Begin
      //ExecDelData;
      //FreeAllIndex;
      m_pDB.DelChandgeDtTable(PMIndex,m_nIndex);
      SetEdit;
      ExecSetGrid;
      ViewChild(m_nIndex);
     End;
    End else
    Begin
     if m_nRowIndex<>-1 then
     Begin
      if FsgGrid.Cells[1,m_nRowIndex]<>'' then
      FreeIndex(StrToInt(FsgGrid.Cells[m_nIDIndex,m_nRowIndex]));
      FsgGrid.ClearRows(m_nRowIndex,1);
     End;
    End;
End;
procedure CL3ChdtEditor.OnDelAllRow;
//Var
//    i : Integer;
Begin
    m_pDB.DelChandgeDtTable(PMIndex,-1);
    SetEdit;
    ExecSetGrid;
    {
    for i:=0 to MAX_CHNG do
    if m_blChngIndex[i]=False then
    Begin
     m_nIndex := i;
     ExecDelData
    End;
    m_pDB.DelPortTable(-1);
    FreeAllIndex;
    ExecSetGrid;
    }
End;
procedure CL3ChdtEditor.OnClickGrid(Sender: TObject; ARow, ACol: Integer);
Begin
    m_nRowIndex := -1;
    if ARow>0 then Begin
     if FsgGrid.Cells[m_nIDIndex,ARow]<>'' then
     Begin
      //m_nIndex := StrToInt(FsgGrid.Cells[m_nIDIndex,ARow]);
      m_nIndex := StrToInt(FsgGrid.Cells[0,ARow]);
      ViewChild(m_nIndex);
     End else m_nIndex := -1;
     m_nRowIndex := ARow;
    End;
    //if (Assigned(mBtiModule)) and (FsgGrid.Cells[5,ARow] = 'BTI_SRV') then
    //  mBtiModule.SetPortID(StrToInt(FsgGrid.Cells[1,ARow]));
End;
//Init Layer
procedure CL3ChdtEditor.OnInitLayer;
Begin
    ExecSetTree;
    ExecInitLayer;
End;
//Index Generator
function  CL3ChdtEditor.GenIndex:Integer;
Var
    i : Integer;
Begin
    for i:=0 to MAX_CHNG do
    if m_blChngIndex[i]=True then
    Begin
     Result := PMindex*256+i;
     exit;
    End;
    Result := -1;
End;
function CL3ChdtEditor.GenIndexSv:Integer;
Begin
    Result := SetIndex(GenIndex);
End;
function CL3ChdtEditor.SetIndex(nIndex : Integer):Integer;
Begin
    {
    nIndex := nIndex and $ff;
    m_blChngIndex[nIndex] := False;
    Result := PMindex*256+nIndex;
    }
    Result := 0;
End;
Procedure CL3ChdtEditor.FreeIndex(nIndex : Integer);
Begin
    m_blChngIndex[nIndex] := True;
End;
Procedure CL3ChdtEditor.FreeAllIndex;
Var
    i : Integer;
Begin
    for i:=0 to MAX_CHNG do
    m_blChngIndex[i] := True;
End;
procedure CL3ChdtEditor.OnExecute(Sender: TObject);
Begin
    //TraceL(5,0,'OnExecute.');
    case m_byTrEditMode of
     ND_EDIT : Begin ExecEditData;End;
     ND_ADD  : Begin ExecAddData;ExecSetTree;End;
     ND_DEL  : Begin ExecDelData;ExecSetTree;End;
    end;
    ExecSetGrid;
    ExecInitLayer;
End;
//Color And Control
procedure CL3ChdtEditor.OnChannelGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
begin
    with (Sender AS TAdvStringGrid)  do Begin
    if (ACol <> 0) and (ARow<>0) and (ARow < RowCount) and
     (not(gdSelected in AState) or (gdFocused in AState)) then
    begin
    end;
    //if ARow=0 then AFont.Style := [fsBold];
    if (ARow<>0) and (ACol<>0)then
     Begin
      if ACol<>0 then
      Begin
       case ACol of
            13,14,15,16: AFont.Color := clMaroon;
       End;      //$00E5D7D0
       case ACol of
            1,2,3,4,9,10,11,12  : if (ARow and 1)<>0 then ABrush.Color := $00E5D7D0 else ABrush.Color := clWhite;
            5,6,7,8,13,14,15,16 : if (ARow and 1)= 0 then ABrush.Color := $00E5D7D0 else ABrush.Color := clWhite;
            //1,2,3,4,9,10,11,12  : if (ARow and 1)<>0 then ABrush.Color := $00E1FFE1 else ABrush.Color := clWhite;
            //5,6,7,8,13,14,15,16 : if (ARow and 1)= 0 then ABrush.Color := $00E1FFE1 else ABrush.Color := clWhite;
       End;
      End;
     End;
    End;
    End;
end;
procedure CL3ChdtEditor.OnGetType(Sender: TObject; ACol, ARow: Integer;var AEditor: TEditorType);
begin
    with FsgGrid^ do
    case ACol of
     2:Begin
        AEditor := edComboList;
        //InitCombo;
        combobox.items.loadfromfile(m_strCurrentDir+'CommandType.dat');
       End;
    end;
end;
end.
