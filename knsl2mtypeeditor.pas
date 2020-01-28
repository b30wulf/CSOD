unit knsl2mtypeeditor;
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,Messages,
  Graphics, Controls, Forms, Dialogs, Spin,
  Grids, BaseGrid, AdvGrid,utlbox,utlconst,utldatabase,knsl1module,
  knsl2module,knsl2qmcmdeditor,knsl2treeloader,knsl5tracer,knsl5config;
type
    CL2MTypeEditor = class
    Private
     FTreeModule    : PTTreeView;
     m_byTrState    : Byte;
     m_byTrEditMode : Byte;
     m_nPageIndex   : Integer;
     m_nIndex       : Integer;
     m_nRowIndex    : Integer;
     m_nRowIndexEx  : Integer;
     m_nIDIndex     : Integer;
     m_nAmRecords   : Integer;
     m_nMasterIndex : Integer;
     m_strCurrentDir: String;
     FsgGrid        : PTAdvStringGrid;
     FsgCGrid       : PTAdvStringGrid;
     FcbCmdCombo    : PTComboBox;
     FChild         : CL2QMCmdEditor;
     FTreeLoader    : PCTreeLoader;
     m_nTehnoLen    : Integer;
     constructor Create;
     function  FindRow(str:String):Integer;
     procedure ViewDefault;
     procedure ViewChild(nIndex:Integer);
     function  FindFreeRow(nIndex:Integer):Integer;
     procedure OnExecute(Sender: TObject);
     procedure ExecEditData;
     procedure ExecAddData;
     procedure ExecDelData;

     procedure AddRecordToGrid(nIndex:Integer;pTbl:PQM_METER);
     function  SetIndex(nIndex : Integer):Integer;
     function  GenIndex:Integer;
     function  GenIndexSv:Integer;
     procedure FreeIndex(nIndex : Integer);
     Procedure FreeAllIndex;
     procedure GetGridRecord(var pTbl:QM_METER);
     function  GetComboIndex(cbCombo:TComboBox;str:String):Integer;
     procedure SetDefaultRow(i:Integer);
    Public
     procedure Init;
     destructor Destroy; override;
     procedure OnFormResize;
     procedure SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
     procedure OnChannelGetCellColor(Sender: TObject; ARow,
               ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
     procedure OnChannelGetCellType(Sender: TObject; ACol,
               ARow: Integer; var AEditor: TEditorType);
     procedure OnClickGrid(Sender: TObject; ARow, ACol: Integer);
     procedure ExecSetEditData(nIndex:Integer);
     procedure ExecSelRowGrid;
     procedure ExecInitLayer;
     procedure ExecSetTree;
     procedure ExecSetGrid;
     procedure OnEditNode;
     procedure OnAddNode;
     procedure OnDeleteNode;
     procedure OnSaveGrid;
     procedure OnSetGrid;
     procedure OnInitLayer;
     procedure OnDelRow;
     procedure OnDelAllRow;
     procedure OnAddRow;
     procedure OnCloneRow;
     procedure SetEdit;
     procedure OpenInfo;
     procedure CloseInfo;
    Public
     property PTreeModule :PTTreeView       read FTreeModule    write FTreeModule;
     property PsgGrid     :PTAdvStringGrid  read FsgGrid        write FsgGrid;
     property PsgCGrid    :PTAdvStringGrid  read FsgCGrid       write FsgCGrid;
     property PcbCmdCombo :PTComboBox       read FcbCmdCombo    write FcbCmdCombo;
     property PPageIndex  :Integer          read m_nPageIndex   write m_nPageIndex;
     property PIndex      :Integer          read m_nIndex       write m_nIndex;
     property PMasterIndex:Integer          read m_nMasterIndex write m_nMasterIndex;
     property PChild      : CL2QMCmdEditor  read FChild         write FChild;
     property PTreeLoader :PCTreeLoader     read FTreeLoader    write FTreeLoader;
    End;
implementation
constructor CL2MTypeEditor.Create;
Begin

End;

destructor CL2MTypeEditor.Destroy;
begin
  if FChild <> nil then FreeAndNil(FChild);

  inherited;
end;

procedure CL2MTypeEditor.Init;
Var
    i : Integer;
Begin
    m_strCurrentDir := ExtractFilePath(Application.ExeName) + '\\Settings\\';
    for i:=0 to MAX_MTYPE do m_blMTypeIndex[i] := True;
    m_nRowIndex         := -1;
    m_nRowIndexEx       := 2;
    m_nIDIndex          := 2; 
    FsgGrid.Color       := KNS_NCOLOR;
    FsgGrid.ColCount    := 5;
    FsgGrid.RowCount    := 100;
    FsgGrid.Cells[0,0]  := '№/T';
    FsgGrid.Cells[1,0]  := 'ID';
    FsgGrid.Cells[2,0]  := 'Тип ID';
    FsgGrid.Cells[3,0]  := 'Название';
    FsgGrid.Cells[4,0]  := 'Комментарий';
    FsgGrid.ColWidths[0]:= 35;
    FsgGrid.ColWidths[1]:= 1;
    FsgGrid.ColWidths[2]:= 1;
    m_nTehnoLen := 2;
    //SetHigthGrid(FsgGrid^,20);
    //ExecSetTree;
    //ExpandTree(FTreeModule^,'Каналы');
    ExecSetGrid;

    FChild             := CL2QMCmdEditor.Create;
    FChild.PTreeModule := FTreeModule;
    FChild.PsgGrid     := FsgCGrid;
    if FsgGrid.Cells[2,1]<>'' then
    FChild.PMasterIndex:= StrToInt(FsgGrid.Cells[2,1]);
    FChild.Init;
End;
procedure CL2MTypeEditor.OpenInfo;
Begin
    FsgGrid.ColWidths[0]:= 35;
    FsgGrid.ColWidths[1]:= 35;
    FsgGrid.ColWidths[2]:= 40;
    m_nTehnoLen := 35+40;
    OnFormResize;
End;
procedure CL2MTypeEditor.CloseInfo;
Begin
    FsgGrid.ColWidths[0]:= 35;
    FsgGrid.ColWidths[1]:= 1;
    FsgGrid.ColWidths[2]:= 1;
    m_nTehnoLen := 2;
    OnFormResize;
End;
procedure CL2MTypeEditor.SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
Var
    i : Integer;
Begin
   // for i:=0 to sgGrid.RowCount-1 do Begin sgGrid.Cells[0,i+1] := IntToStr(i+1); sgGrid.RowHeights[i]:= nHigth;End;
End;
procedure CL2MTypeEditor.OnFormResize;
Var
    i : Integer;
Begin
    if Assigned(FsgGrid)=true then
    for i:=3 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-m_nTehnoLen-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1-2));
    FChild.OnFormResize;
End;
procedure CL2MTypeEditor.SetEdit;
Var
    pTbl : QM_METERS;
    i    : Integer;
begin
    m_nRowIndex := -1;
    FreeAllIndex;
    if m_pDB.GetMetersTypeTable(pTbl)=True then for i:=0 to pTbl.m_swAmMeterType-1 do SetIndex(pTbl.m_sMeterType[i].m_swType);
end;
//Edit Add Del Request
procedure CL2MTypeEditor.OnEditNode;
begin
end;
procedure CL2MTypeEditor.OnAddNode;
begin
end;
procedure CL2MTypeEditor.OnDeleteNode;
Begin
End;
//Edit Add Del Execute
procedure CL2MTypeEditor.ExecSetEditData(nIndex:Integer);
Begin
    TraceL(1,0,'ExecSetEditData.');
End;
procedure CL2MTypeEditor.ExecEditData;
Begin
    TraceL(1,0,'ExecEditData.');
End;
procedure CL2MTypeEditor.ExecAddData;
Begin
    TraceL(1,0,'ExecAddData.');
End;
procedure CL2MTypeEditor.ExecDelData;
Begin
    TraceL(1,0,'ExecDelData.');
End;
procedure CL2MTypeEditor.ExecInitLayer;
Begin
    TraceL(1,0,'ExecInitLayer.');
    mL2Module.Init;
End;
//Tree Reload
procedure CL2MTypeEditor.ExecSetTree;
Begin
    TraceL(1,0,'ExecSetTree.');
    FTreeLoader.LoadTree;
End;
//Grid Routine
procedure CL2MTypeEditor.ExecSelRowGrid;
Begin
    FsgGrid.SelectRows(FindRow(IntToStr(m_nIndex)),1);
    FsgGrid.Refresh;
    ViewChild(m_nIndex);
End;
function CL2MTypeEditor.FindRow(str:String):Integer;
Var
   i : Integer;
Begin
   for i:=1 to 60 do if FsgGrid.Cells[m_nIDIndex,i]=str then
    Begin
     if (i-FsgGrid.VisibleRowCount)>0  then FsgGrid.TopRow := i-FsgGrid.VisibleRowCount+1 else FsgGrid.TopRow := 1;
     Result := i;
     exit;
    End;
    Result := 1;
End;
procedure CL2MTypeEditor.ViewChild(nIndex:Integer);
Begin
    if m_blCL2QmCEditor=False then
    if FChild<>Nil then
    Begin
     FChild.PMasterIndex := nIndex;
     FChild.ExecSetGrid;
    End;
End;
procedure CL2MTypeEditor.ExecSetGrid;
Var
    pTbl : QM_METERS;
    i : Integer;
Begin
    FsgGrid.ClearNormalCells;
    //FreeAllIndex;
    if m_pDB.GetMetersTypeTable(pTbl)=True then
    Begin
     m_nAmRecords := pTbl.m_swAmMeterType;
     for i:=0 to pTbl.m_swAmMeterType-1 do
     Begin
      SetIndex(pTbl.m_sMeterType[i].m_swType);
      AddRecordToGrid(i,@pTbl.m_sMeterType[i]);
     End;
     ViewDefault;
    End;
End;
procedure CL2MTypeEditor.ViewDefault;
Var
    nIndex : Integer;
    str : String;
Begin
    if m_nRowIndexEx<>-1 then
    if(FsgGrid.Cells[m_nIDIndex,m_nRowIndexEx]<>'')then
    Begin
     nIndex := StrToInt(FsgGrid.Cells[m_nIDIndex,m_nRowIndexEx]);
     ViewChild(nIndex);
    End;
End;
procedure CL2MTypeEditor.AddRecordToGrid(nIndex:Integer;pTbl:PQM_METER);
Var
   nY : Integer;
   nVisible : Integer;
Begin
    nY := nIndex+1;
    nVisible := round(FsgGrid.Height/21);
    //if (nY-nVisible)>0  then FsgGrid.TopRow := nY-nVisible;
    with pTbl^ do Begin
     FsgGrid.Cells[0,nY] := IntToStr(nY);
     FsgGrid.Cells[1,nY] := IntToStr(m_swID);
     FsgGrid.Cells[2,nY] := IntToStr(m_swType);
     FsgGrid.Cells[3,nY] := m_sName;
     FsgGrid.Cells[4,nY] := m_sComment;
    End;
End;
procedure CL2MTypeEditor.OnSetGrid;
Begin
    ExecSetGrid;
End;
procedure CL2MTypeEditor.OnSaveGrid;
Var
    i : Integer;
    pTbl:QM_METER;
Begin
    for i:=1 to FsgGrid.RowCount do
    Begin
     if FsgGrid.Cells[3,i]='' then break;
     pTbl.m_swID := i;
     GetGridRecord(pTbl);
     if m_pDB.AddMeterTypeTable(pTbl)=True then SetIndex(pTbl.m_swType);
    End;
    ExecSetGrid;
End;
function CL2MTypeEditor.FindFreeRow(nIndex:Integer):Integer;
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
procedure CL2MTypeEditor.GetGridRecord(var pTbl:QM_METER);
Var
    i : Integer;
    str : String;
Begin
    i := pTbl.m_swID;
    with pTbl do Begin
     SetDefaultRow(i);
     m_swID     := StrToInt(FsgGrid.Cells[1,i]);
     m_swType   := StrToInt(FsgGrid.Cells[2,i]);
     m_sName    := FsgGrid.Cells[3,i];
     m_sComment := FsgGrid.Cells[4,i];
    End;
End;
procedure CL2MTypeEditor.OnAddRow;
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
End;
procedure CL2MTypeEditor.OnCloneRow;
Var
    nIndex : Integer;
    pTbl   : QM_METER;
Begin
    if m_nRowIndex<>-1 then
    if m_nRowIndex<=FindFreeRow(3)-1 then
    Begin
     pTbl.m_swID   := m_nRowIndex;
     GetGridRecord(pTbl);
     pTbl.m_swType := GenIndexSv;
     AddRecordToGrid(FindFreeRow(3)-1,@pTbl);
    End;
End;
procedure CL2MTypeEditor.SetDefaultRow(i:Integer);
Begin
    if FsgGrid.Cells[1,i]='' then FsgGrid.Cells[1,i] := '-1';
    if FsgGrid.Cells[2,i]='' then FsgGrid.Cells[2,i] := IntToStr(GenIndex);
    if FsgGrid.Cells[3,i]='' then FsgGrid.Cells[3,i] := 'Meter';
    if FsgGrid.Cells[4,i]='' then FsgGrid.Cells[4,i] := 'X Meter';
End;
procedure CL2MTypeEditor.OnClickGrid(Sender: TObject; ARow, ACol: Integer);
Begin
    m_nRowIndex := -1;
    m_nRowIndexEx := -1;
    if ARow>0 then Begin
     m_nRowIndex := ARow;
     m_nRowIndexEx := ARow;
     if FsgGrid.Cells[m_nIDIndex,ARow]<>'' then
     Begin
      m_nIndex := StrToInt(FsgGrid.Cells[m_nIDIndex,ARow]);
      ViewChild(m_nIndex);
     End else m_nIndex := -1;
    End;
End;
procedure CL2MTypeEditor.OnDelRow;
Var
    nFind : Integer;
Begin
    if m_nAmRecords=FindFreeRow(3)-1 then
    Begin
     if m_nIndex<>-1 then
     Begin
      FreeAllIndex;
      m_pDB.DelMeterTypeTable(m_nIndex);
      ExecSetGrid;
      ViewChild(m_nIndex);
     End;
    End else
    Begin
     if m_nRowIndex<>-1 then
     Begin
      if FsgGrid.Cells[m_nIDIndex,m_nRowIndex]<>'' then
      FreeIndex(StrToInt(FsgGrid.Cells[m_nIDIndex,m_nRowIndex]));
      FsgGrid.ClearRows(m_nRowIndex,1);
      //SetHigthGrid(FsgGrid^,20);
     End;
    End;
End;
procedure CL2MTypeEditor.OnDelAllRow;
Begin
    m_pDB.DelMeterTypeTable(-1);
    FreeAllIndex;
    ExecSetGrid;
End;
//Init Layer
procedure CL2MTypeEditor.OnInitLayer;
Begin
    //ExecSetTree;
    ExecInitLayer;
End;
//Index Generator
function  CL2MTypeEditor.GenIndex:Integer;
Var
    i : Integer;
Begin
    for i:=0 to MAX_MTYPE do
    if m_blMTypeIndex[i]=True then
    Begin
     Result := i;
     exit;
    End;
    Result := -1;
End;
function  CL2MTypeEditor.GenIndexSv:Integer;
Begin
    Result := SetIndex(GenIndex);
End;
function CL2MTypeEditor.SetIndex(nIndex : Integer):Integer;
Begin
    m_blMTypeIndex[nIndex] := False;
    Result := nIndex;
End;
Procedure CL2MTypeEditor.FreeIndex(nIndex : Integer);
Begin
    m_blMTypeIndex[nIndex] := True;
End;
Procedure CL2MTypeEditor.FreeAllIndex;
Var
    i : Integer;
Begin
    for i:=0 to MAX_MTYPE do
    m_blMTypeIndex[i] := True;
End;
procedure CL2MTypeEditor.OnExecute(Sender: TObject);
Begin
    //TraceL(5,0,'OnExecute.');
    case m_byTrEditMode of
     ND_EDIT : Begin ExecEditData;End;
     ND_ADD  : Begin ExecAddData;ExecSetTree;End;
     ND_DEL  : Begin ExecDelData;ExecSetTree;End;
    end;
    ExecSetGrid;
    //ExecInitLayer;
End;
//Color And Control
procedure CL2MTypeEditor.OnChannelGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
     OnGlGetCellColor(Sender,ARow,ACol,AState,ABrush,AFont);
end;
procedure CL2MTypeEditor.OnChannelGetCellType(Sender: TObject; ACol, ARow: Integer;var AEditor: TEditorType);
begin
    with FsgGrid^ do
    case ACol of
     3:Begin
        AEditor := edComboList;
        combobox.items.loadfromfile(m_strCurrentDir+'CommandType.dat');
       End;
     7:Begin
        AEditor := edComboList;
        combobox.items.loadfromfile(m_strCurrentDir+'State.dat');
       End;
    end;
end;
function CL2MTypeEditor.GetComboIndex(cbCombo:TComboBox;str:String):Integer;
Var
    i : Integer;
Begin
    for i:=0 to cbCombo.Items.Count-1 do
    Begin
      if cbCombo.Items[i]=str then
      Begin
       Result := i;
       exit;
      End;
    End;
End;
end.
