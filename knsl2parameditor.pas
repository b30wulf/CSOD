unit knsl2parameditor;
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,Messages,
  Graphics, Controls, Forms, Dialogs, Spin,
  Grids, BaseGrid, AdvGrid,utlbox,utlconst,utldatabase,knsl1module,
  knsl2module,knsl2qmcmdeditor,knsl2treeloader,knsl5tracer,knsl5config;
type
{
m_swID      : Word;
     m_swType    : Word;
     m_sName     : String[40];
     m_sShName   : String[40];
     m_sEName    : String[40];
     m_swActive  : Byte;
     m_swStatus  : Byte;
     m_swIsGraph : Byte;
}
    CL2ParamEditor = class
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
     m_nTariffList  : TStringList;
     m_nTehnoLen    : Integer;

     m_nSaveList    : TStringList;
     m_nCommList : TStringList;
     constructor Create;
     procedure InitCombo;
     function  FindRow(str:String):Integer;
     procedure ViewDefault;
     procedure ViewChild(nIndex:Integer);
     function  FindFreeRow(nIndex:Integer):Integer;
     procedure OnExecute(Sender: TObject);
     procedure ExecEditData;
     procedure ExecAddData;
     procedure ExecDelData;

     procedure AddRecordToGrid(nIndex:Integer;pTbl:PQM_PARAM);
     function  SetIndex(nIndex : Integer):Integer;
     function  GenIndex:Integer;
     function  GenIndexSv:Integer;
     procedure FreeIndex(nIndex : Integer);
     Procedure FreeAllIndex;
     procedure GetGridRecord(var pTbl:QM_PARAM);
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
     procedure OnLoadFromFile;
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
constructor CL2ParamEditor.Create;
Begin

End;

destructor CL2ParamEditor.Destroy;
begin
  if m_nTariffList <> nil then FreeAndNil(m_nTariffList);
  if m_nSaveList <> nil then FreeAndNil(m_nSaveList);
  if m_nCommList <> nil then FreeAndNil(m_nCommList);
  inherited;
end;

procedure CL2ParamEditor.Init;
Var
    i : Integer;
Begin
    m_strCurrentDir := ExtractFilePath(Application.ExeName) + '\\Settings\\';
    for i:=0 to MAX_PTYPE do m_blPTypeIndex[i] := True;

    m_nTariffList  := TStringList.Create;
    //m_nActiveList  := TStringList.Create;
    m_nSaveList    := TStringList.Create;
    m_nCommList := TStringList.Create;

    //m_nActiveList.LoadFromFile(m_strCurrentDir+'Active.dat');

    m_nSaveList.LoadFromFile(m_strCurrentDir+'StateSaveParam.dat');
    m_nCommList.LoadFromFile(m_strCurrentDir+'CommandType.dat');

    m_nRowIndex         := -1;
    m_nRowIndexEx       := 2;
    m_nIDIndex          := 2;
    FsgGrid.Color       := KNS_NCOLOR;
    FsgGrid.ColCount    := 13;
    FsgGrid.RowCount    := 150 + 3;
    FsgGrid.Cells[0,0]  := '�/T';
    FsgGrid.Cells[1,0]  := 'ID';
    FsgGrid.Cells[2,0]  := '��� ID';
    FsgGrid.Cells[3,0]  := '��������';
    //FsgGrid.Cells[4,0]  := '����.����.';
    FsgGrid.Cells[4,0]  := '�����������';
    FsgGrid.Cells[5,0]  := '��.���.';
    FsgGrid.Cells[6,0]  := '�-� ����(�)';
    FsgGrid.Cells[7,0]  := '���.';
    FsgGrid.Cells[8,0]  := '���.';
    FsgGrid.Cells[9,0]  := '������';
    FsgGrid.Cells[10,0] := '��� ��.';
    FsgGrid.Cells[11,0] := '��� ������';
    FsgGrid.Cells[12,0] := '�-�';
    FsgGrid.ColWidths[0]:= 35;
    FsgGrid.ColWidths[1]:= 1;
    FsgGrid.ColWidths[2]:= 1;
    FsgGrid.ColWidths[3]:= 180;
    m_nTehnoLen := 184;
    //SetHigthGrid(FsgGrid^,20);
    InitCombo;
    ExecSetGrid;

    {
     FChild             := CL2QMCmdEditor.Create;
     FChild.PTreeModule := FTreeModule;
     FChild.PsgGrid     := FsgCGrid;
     if FsgGrid.Cells[2,1]<>'' then
     FChild.PMasterIndex:= StrToInt(FsgGrid.Cells[2,1]);
     FChild.Init;
    }
End;
procedure CL2ParamEditor.OpenInfo;
Begin
    FsgGrid.ColWidths[0]:= 35;
    FsgGrid.ColWidths[1]:= 35;
    FsgGrid.ColWidths[2]:= 40;
    FsgGrid.ColWidths[3]:= 180;
    m_nTehnoLen := 35+40+180;
    OnFormResize;
End;
procedure CL2ParamEditor.CloseInfo;
Begin
    FsgGrid.ColWidths[0]:= 35;
    FsgGrid.ColWidths[1]:= 1;
    FsgGrid.ColWidths[2]:= 1;
    FsgGrid.ColWidths[3]:= 180;
    m_nTehnoLen := 184;
    OnFormResize;
End;
procedure CL2ParamEditor.SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
Var
    i : Integer;
Begin
   // for i:=0 to sgGrid.RowCount-1 do Begin sgGrid.Cells[0,i+1] := IntToStr(i+1); sgGrid.RowHeights[i]:= nHigth;End;
End;
procedure CL2ParamEditor.OnFormResize;
Var
    i : Integer;
Begin
    if Assigned(FsgGrid)=true then
    for i:=4 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-m_nTehnoLen-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1-3));
    if FChild<>Nil then FChild.OnFormResize;
End;
procedure CL2ParamEditor.SetEdit;
Var
    pTbl : QM_PARAMS;
    i    : Integer;
Begin
    m_nRowIndex := -1;
    FreeAllIndex;
    if m_pDB.GetParamsTypeTable(pTbl)=True then for i:=0 to pTbl.Count-1 do SetIndex(pTbl.Items[i].m_swType);
End;
procedure CL2ParamEditor.InitCombo;
Var
    pTable : TM_TARIFFSS;
    i : Integer;
Begin
    if m_pDB.GetTMTarifsTable(0,0,0,pTable) then
    Begin
     FsgGrid.Combobox.Items.Clear;
     m_nTariffList.Clear;
     for i:=0 to pTable.Count-1 do
     Begin
      FsgGrid.Combobox.Items.Add(pTable.Items[i].m_sName);
      m_nTariffList.Add(pTable.Items[i].m_sName);
     End;
    End;
End;
//Edit Add Del Request
procedure CL2ParamEditor.OnEditNode;
begin
end;
procedure CL2ParamEditor.OnAddNode;
begin
end;
procedure CL2ParamEditor.OnDeleteNode;
Begin
End;
//Edit Add Del Execute
procedure CL2ParamEditor.ExecSetEditData(nIndex:Integer);
Begin
    TraceL(1,0,'ExecSetEditData.');
End;
procedure CL2ParamEditor.ExecEditData;
Begin
    TraceL(1,0,'ExecEditData.');
End;
procedure CL2ParamEditor.ExecAddData;
Begin
    TraceL(1,0,'ExecAddData.');
End;
procedure CL2ParamEditor.ExecDelData;
Begin
    TraceL(1,0,'ExecDelData.');
End;
procedure CL2ParamEditor.ExecInitLayer;
Begin
    TraceL(1,0,'ExecInitLayer.');
    mL2Module.Init;
End;
//Tree Reload
procedure CL2ParamEditor.ExecSetTree;
Begin
    TraceL(1,0,'ExecSetTree.');
    FTreeLoader.LoadTree;
End;
//Grid Routine
procedure CL2ParamEditor.OnLoadFromFile;
Var
    i : Integer;
Begin
    m_nCommList.Clear;
    m_nCommList.LoadFromFile(m_strCurrentDir+'CommandType.dat');
    for i:=0 to m_nCommList.Count-1 do
    Begin
     FsgGrid.Cells[3,i+1] := m_nCommList.Strings[i];
    End;
End;
procedure CL2ParamEditor.ExecSelRowGrid;
Begin
    FsgGrid.SelectRows(FindRow(IntToStr(m_nIndex)),1);
    FsgGrid.Refresh;
    ViewChild(m_nIndex);
End;
function CL2ParamEditor.FindRow(str:String):Integer;
Var
   i : Integer;
Begin
   for i:=1 to FsgGrid.RowCount-1 do if FsgGrid.Cells[m_nIDIndex,i]=str then
    Begin
     if (i-FsgGrid.VisibleRowCount)>0  then FsgGrid.TopRow := i-FsgGrid.VisibleRowCount+1 else FsgGrid.TopRow := 1;
     Result := i;
     exit;
    End;
    Result := 1;
End;
procedure CL2ParamEditor.ViewChild(nIndex:Integer);
Begin
    if FChild<>Nil then
    Begin
     FChild.PMasterIndex := nIndex;
     FChild.ExecSetGrid;
    End;
End;
procedure CL2ParamEditor.ExecSetGrid;
Var
    pTbl : QM_PARAMS;
    i : Integer;
Begin
    FsgGrid.ClearNormalCells;
    //FreeAllIndex;
    if m_pDB.GetParamsTypeTable(pTbl)=True then
    Begin
     m_nAmRecords := pTbl.Count;
     for i:=0 to pTbl.Count-1 do
     Begin
      SetIndex(pTbl.Items[i].m_swType);
      AddRecordToGrid(i,@pTbl.Items[i]);
     End;
     ViewDefault;
    End;
End;
procedure CL2ParamEditor.ViewDefault;
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
{
m_swID      : Word;
     m_swType    : Word;
     m_sName     : String[40];
     m_sShName   : String[30];
     m_sEName    : String[10];
     m_sEMet     : String[10];
     m_swActive  : Byte;
     m_swStatus  : Byte;
     m_swIsGraph : Byte;
}
procedure CL2ParamEditor.AddRecordToGrid(nIndex:Integer;pTbl:PQM_PARAM);
Var
   nY : Integer;
   nVisible : Integer;
Begin
    nY := nIndex+1;
    nVisible := round(FsgGrid.Height/21);
    //if (nY-nVisible)>0  then FsgGrid.TopRow := nY-nVisible;
    with pTbl^ do Begin
     FsgGrid.Cells[0,nY]  := IntToStr(nY);
     FsgGrid.Cells[1,nY]  := IntToStr(m_swID);
     FsgGrid.Cells[2,nY]  := IntToStr(m_swType);
     FsgGrid.Cells[3,nY]  := m_sName;
     //FsgGrid.Cells[4,nY]  := m_sShName;
     FsgGrid.Cells[4,nY]  := m_sEName;
     FsgGrid.Cells[5,nY]  := m_sEMet;
     FsgGrid.Cells[6,nY]  := m_nSvPeriodList.Strings[m_swSvPeriod];
     FsgGrid.Cells[7,nY]  := m_nParamList.Strings[m_sblTarif];
     FsgGrid.Cells[8,nY]  := m_nActiveList.Strings[m_swActive];
     if m_swStatus<=4 then FsgGrid.Cells[9,nY]  := m_nStatusList.Strings[m_swStatus];
     FsgGrid.Cells[10,nY] := m_nSaveList.Strings[m_swIsGraph];
     FsgGrid.Cells[11,nY] := m_nDataGroup.Strings[m_sbyDataGroup];
     FsgGrid.Cells[12,nY] := m_nSvPeriodList.Strings[m_sbyDeltaPer];
    End;
End;
procedure CL2ParamEditor.OnSetGrid;
Begin
    ExecSetGrid;
End;
procedure CL2ParamEditor.OnSaveGrid;
Var
    i : Integer;
    pTbl:QM_PARAM;
Begin
    for i:=1 to FsgGrid.RowCount-1 do
    Begin
     if FsgGrid.Cells[3,i]='' then break;
     pTbl.m_swID := i;
     GetGridRecord(pTbl);
     if m_pDB.AddParamTypeTable(pTbl)=True then SetIndex(pTbl.m_swType);
    End;
    ExecSetGrid;
End;
function CL2ParamEditor.FindFreeRow(nIndex:Integer):Integer;
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

procedure CL2ParamEditor.GetGridRecord(var pTbl:QM_PARAM);
Var
    i : Integer;
    str : String;
Begin
    i := pTbl.m_swID;
    with pTbl do Begin
     SetDefaultRow(i);
     m_swID         := StrToInt(FsgGrid.Cells[1,i]);
     m_swType       := StrToInt(FsgGrid.Cells[2,i]);
     m_sName        := FsgGrid.Cells[3,i];
     //m_sShName    := FsgGrid.Cells[4,i];
     m_sEName       := FsgGrid.Cells[4,i];
     m_sEMet        := FsgGrid.Cells[5,i];
     m_swSvPeriod   := m_nSvPeriodList.IndexOf(FsgGrid.Cells[6,i]);
     m_sblTarif     := m_nParamList.IndexOf(FsgGrid.Cells[7,i]);
     m_swActive     := m_nActiveList.IndexOf(FsgGrid.Cells[8,i]);
     m_swStatus     := m_nStatusList.IndexOf(FsgGrid.Cells[9,i]);
     m_swIsGraph    := m_nSaveList.IndexOf(FsgGrid.Cells[10,i]);
     m_sbyDataGroup := m_nDataGroup.IndexOf(FsgGrid.Cells[11,i]);
     m_sbyDeltaPer  := m_nSvPeriodList.IndexOf(FsgGrid.Cells[12,i]);
    End;
End;
procedure CL2ParamEditor.OnAddRow;
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
procedure CL2ParamEditor.OnCloneRow;
Var
    nIndex : Integer;
    pTbl   : QM_PARAM;
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
{
m_swID      : Word;
     m_swType    : Word;
     m_sName     : String[40];
     m_sShName   : String[40];
     m_sEName    : String[40];
     m_swActive  : Byte;
     m_swStatus  : Byte;
     m_swIsGraph : Byte;
}
procedure CL2ParamEditor.SetDefaultRow(i:Integer);
Var
    dtTM   : TDateTime;
    wValue : Word;
Begin
    wValue := 0;
    DecodeDate(dtTM,wValue,wValue,wValue);
    DecodeTime(dtTM,wValue,wValue,wValue,wValue);
    if FsgGrid.Cells[1,i]='' then FsgGrid.Cells[1,i]  := '-1';
    if FsgGrid.Cells[2,i]='' then FsgGrid.Cells[2,i]  := IntToStr(GenIndex);
    if FsgGrid.Cells[3,i]='' then FsgGrid.Cells[3,i]  := '��.��������� �����������';
    //if FsgGrid.Cells[4,i]='' then FsgGrid.Cells[4,i]  := 'EN.Sum.Nak';
    if FsgGrid.Cells[4,i]='' then FsgGrid.Cells[4,i]  := 'E+';
    if FsgGrid.Cells[5,i]='' then FsgGrid.Cells[5,i]  := '���';
    if FsgGrid.Cells[6,i]='' then FsgGrid.Cells[6,i]  := m_nSvPeriodList.Strings[2];
    if FsgGrid.Cells[7,i]='' then FsgGrid.Cells[7,i]  := m_nParamList.Strings[1];
    if FsgGrid.Cells[8,i]='' then FsgGrid.Cells[8,i]  := m_nActiveList.Strings[1];
    if FsgGrid.Cells[9,i]='' then FsgGrid.Cells[9,i]  := m_nStatusList.Strings[1];
    if FsgGrid.Cells[10,i]=''then FsgGrid.Cells[10,i] := m_nSaveList.Strings[1];
    if FsgGrid.Cells[11,i]=''then FsgGrid.Cells[11,i] := m_nDataGroup.Strings[0];
    if FsgGrid.Cells[12,i]=''then FsgGrid.Cells[12,i] := m_nSvPeriodList.Strings[0];
End;
procedure CL2ParamEditor.OnClickGrid(Sender: TObject; ARow, ACol: Integer);
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
procedure CL2ParamEditor.OnDelRow;
Var
    nFind : Integer;
Begin
    if m_nAmRecords=FindFreeRow(3)-1 then
    Begin
     if m_nIndex<>-1 then
     Begin
      FreeAllIndex;
      m_pDB.DelParamTypeTable(m_nIndex);
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
      SetHigthGrid(FsgGrid^,20);
     End;
    End;
End;
procedure CL2ParamEditor.OnDelAllRow;
Begin
    m_pDB.DelParamTypeTable(-1);
    FreeAllIndex;
    ExecSetGrid;
End;
//Init Layer
procedure CL2ParamEditor.OnInitLayer;
Begin
    //ExecSetTree;
    ExecInitLayer;
End;
//Index Generator
function  CL2ParamEditor.GenIndex:Integer;
Var
    i : Integer;
Begin
    for i:=0 to MAX_PTYPE do
    if m_blPTypeIndex[i]=True then
    Begin
     Result := i;
     exit;
    End;
    Result := -1;
End;
function  CL2ParamEditor.GenIndexSv:Integer;
Begin
    Result := SetIndex(GenIndex);
End;
function CL2ParamEditor.SetIndex(nIndex : Integer):Integer;
Begin
    m_blPTypeIndex[nIndex] := False;
    Result := nIndex;
End;
Procedure CL2ParamEditor.FreeIndex(nIndex : Integer);
Begin
    m_blPTypeIndex[nIndex] := True;
End;
Procedure CL2ParamEditor.FreeAllIndex;
Var
    i : Integer;
Begin
    for i:=0 to MAX_PTYPE do
    m_blPTypeIndex[i] := True;
End;
procedure CL2ParamEditor.OnExecute(Sender: TObject);
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
procedure CL2ParamEditor.OnChannelGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
    OnGlGetCellColor(Sender,ARow,ACol,AState,ABrush,AFont);
end;
{
FsgGrid.Cells[6,0]  := '�-� ����(�)';
    FsgGrid.Cells[7,0]  := '���.';
    FsgGrid.Cells[8,0]  := '���.';
    FsgGrid.Cells[9,0]  := '������';
    FsgGrid.Cells[10,0] := '��� ��.';
}
procedure CL2ParamEditor.OnChannelGetCellType(Sender: TObject; ACol, ARow: Integer;var AEditor: TEditorType);
begin
    with FsgGrid^ do
    case ACol of
     6,12:Begin
        AEditor := edComboList;
        combobox.items.loadfromfile(m_strCurrentDir+'SavePeriod.dat');
       End;
     7:Begin
        AEditor := edComboList;
        combobox.items.loadfromfile(m_strCurrentDir+'ParamType.dat');
        //InitCombo;
       End;
     8:Begin
        AEditor := edComboList;
        combobox.items.loadfromfile(m_strCurrentDir+'Active.dat');
       End;
     9:Begin
        AEditor := edComboList;
        combobox.items.loadfromfile(m_strCurrentDir+'StatParam.dat');
       End;
     10:Begin
        AEditor := edComboList;
        combobox.items.loadfromfile(m_strCurrentDir+'StateSaveParam.dat');
       End;
     11:Begin
        AEditor := edComboList;
        combobox.items.loadfromfile(m_strCurrentDir+'DataGroup.dat');
       End;
    end;
end;
function CL2ParamEditor.GetComboIndex(cbCombo:TComboBox;str:String):Integer;
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
