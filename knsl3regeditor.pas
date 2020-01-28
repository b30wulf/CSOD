unit knsl3regeditor;
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,Messages,
  Graphics, Controls, Forms, Dialogs, Spin,
  Grids, BaseGrid, AdvGrid,utlbox,utlconst,utldatabase,knsl2treeloader,knsl5tracer,knsl5config;
type
    CL3RegEditor = class
    Private
     m_byTrState    : Byte;
     m_byTrEditMode : Byte;
     m_nIDIndex     : Integer;
     m_nRowIndex    : Integer;
     m_nRowIndexEx  : Integer;
     m_nColIndex    : Integer;
     m_nAmRecords   : Integer;
     m_nPageIndex   : Integer;
     m_nIndex       : Integer;
     m_nMasterIndex : Integer;
     m_strCurrentDir: String;
     m_nTypeList    : TStringList;

     FsgGrid        : PTAdvStringGrid;
     //FChild         : CL2CmdEditor;
     FTreeLoader    : PCTreeLoader;
     constructor Create;
     //procedure InitCombo;
     procedure OnExecute(Sender: TObject);
     procedure ViewDefault;
     procedure ViewChild(nIndex:Integer);
     procedure ExecEditData;
     procedure ExecAddData;
     procedure ExecDelData;

     procedure AddRecordToGrid(nIndex:Integer;pTbl:PSL3REGION);
     function  SetIndex(nIndex : Integer):Integer;
     function  GenIndex:Integer;
     function  GenIndexSv:Integer;
     procedure FreeIndex(nIndex : Integer);
     Procedure FreeAllIndex;
     function  FindFreeRow(nIndex:Integer):Integer;
     procedure GetGridRecord(var pTbl:SL3REGION);
     function  GetComboIndex(cbCombo:TComboBox;str:String):Integer;
     procedure SetDefaultRow(i:Integer);
    Public
     procedure Init;
     //procedure ExecSelRowGrid;
     procedure OnFormResize;
     procedure OnSetForAll;
     procedure OnChannelGetCellColor(Sender: TObject; ARow,
               ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
     procedure OnGetType(Sender: TObject; ACol,
               ARow: Integer; var AEditor: TEditorType);
     procedure OnClickGrid(Sender: TObject; ARow, ACol: Integer);
     procedure OnComboChandge(Sender: TObject; ACol, ARow,
               AItemIndex: Integer; ASelection: String);
     procedure ExecSetEditData(nIndex:Integer);
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
    Public
     //property PTreeModule :PTTreeView      read FTreeModule    write FTreeModule;
     property PsgGrid :PTAdvStringGrid     read FsgGrid        write FsgGrid;
     //property PcbCmdCombo :PTComboBox      read FcbCmdCombo    write FcbCmdCombo;
     property PPageIndex  :Integer         read m_nPageIndex   write m_nPageIndex;
     property PIndex      :Integer         read m_nIndex       write m_nIndex;
     property PMasterIndex:Integer         read m_nMasterIndex write m_nMasterIndex;
     property PTreeLoader :PCTreeLoader    read FTreeLoader    write FTreeLoader;
    End;
implementation
constructor CL3RegEditor.Create;
Begin

End;
{
SL3REGION = packed record
     m_swID      : Integer;
     m_nRegionID : Integer;
     m_nRegNM    : string[100];
     m_sKSP      : string[5];
     m_sbyEnable : Byte;
     Item        : SL3ABONS;
    End;
}
procedure CL3RegEditor.Init;
Var
    i : Integer;
Begin
    m_strCurrentDir := ExtractFilePath(Application.ExeName) + '\\Settings\\';
    for i:=0 to MAX_REGION do m_blRegionIndex[i] := True;
    m_nRowIndex         := -1;
    m_nRowIndexEx       := -1;
    m_nColIndex         := -1;
    m_nIDIndex          := 2;
    //FsgGrid.Color       := KNS_NCOLOR;
    FsgGrid.ColCount    := 6;
    FsgGrid.RowCount    := 20;
    FsgGrid.Cells[0,0]  := '№/T';
    FsgGrid.Cells[1,0]  := 'ID';
    FsgGrid.Cells[2,0]  := 'Регион ID';
    FsgGrid.Cells[3,0]  := 'Название';
    FsgGrid.Cells[4,0]  := 'КСП';
    FsgGrid.Cells[5,0]  := 'Активность';
    FsgGrid.ColWidths[0]:= 30;
    FsgGrid.ColWidths[1]:= 30;
    FsgGrid.ColWidths[2]:= 40;
    FsgGrid.ColWidths[3]:= 300;
    ExecSetGrid;
End;
procedure CL3RegEditor.SetEdit;
Var
    pTbl : SL3REGIONS;
    i    : Integer;
Begin
    m_nRowIndex  := -1;
    FreeAllIndex;
    if m_pDB.GetRegionsTable(pTbl)=True then for i:=0 to pTbl.Count-1 do SetIndex(pTbl.Items[i].m_nRegionID);
End;
procedure CL3RegEditor.OnSetForAll;
Var
    i : Integer;
Begin
    if m_nRowIndex<>-1 then
    Begin
     for i:=1 to FsgGrid.RowCount-1 do
     if FsgGrid.Cells[m_nIDIndex,i]<>'' then
     FsgGrid.Cells[m_nColIndex,i] := FsgGrid.Cells[m_nColIndex,m_nRowIndex];
    End;
End;

procedure CL3RegEditor.OnFormResize;
Var
    i : Integer;
Begin
    for i:=4 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-(30+40+300)-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1-3));
End;
//Edit Add Del Request

procedure CL3RegEditor.OnEditNode;
begin
end;
procedure CL3RegEditor.OnAddNode;
begin
end;
procedure CL3RegEditor.OnDeleteNode;
Begin
End;
//Edit Add Del Execute
procedure CL3RegEditor.ExecSetEditData(nIndex:Integer);
Begin
    TraceL(1,0,'ExecSetEditData.');
End;
procedure CL3RegEditor.ExecEditData;
Begin
    TraceL(1,0,'ExecEditData.');
End;
procedure CL3RegEditor.ExecAddData;
Begin
    TraceL(1,0,'ExecAddData.');
End;
procedure CL3RegEditor.ExecDelData;
Begin
    TraceL(1,0,'ExecDelData.');
End;
procedure CL3RegEditor.ExecInitLayer;
Begin
    TraceL(1,0,'ExecInitLayer.');
    //mL2Module.Init;
End;
//Tree Reload
procedure CL3RegEditor.ExecSetTree;
Begin
    TraceL(1,0,'ExecSetTree.');
    FTreeLoader.LoadTree;
End;
//Grid Routine
{
     m_swID      : Word;
     m_swType    : Word;
     m_swCMDID   : Word;
     m_sName     : String[40];
     m_swSpec0   : Word;
     m_swSpec1   : Word;
     m_swSpec2   : Word;
     m_sbyEnable : Byte;
     m_sComment  : String[40];
}
procedure CL3RegEditor.ExecSetGrid;
Var
    pTbl : SL3REGIONS;
    i : Integer;
Begin
    try
    FsgGrid.ClearNormalCells;
    if m_pDB.GetRegionsTableUN(pTbl)=True then
    Begin
     m_nAmRecords := pTbl.Count;
     for i:=0 to pTbl.Count-1 do
     Begin
      SetIndex(pTbl.Items[i].m_nRegionID);
      AddRecordToGrid(i,@pTbl.Items[i]);
     End;
     ViewDefault;
    End;
     except
     TraceER('(__)CL3MD::>Error In CL3RegEditor.ExecSetGrid;!!!');
    end;
End;
procedure CL3RegEditor.AddRecordToGrid(nIndex:Integer;pTbl:PSL3REGION);
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
     FsgGrid.Cells[2,nY]  := IntToStr(m_nRegionID);
     FsgGrid.Cells[3,nY]  := m_nRegNM;
     FsgGrid.Cells[4,nY]  := m_sKSP;
     FsgGrid.Cells[5,nY]  := m_nEsNoList.Strings[m_sbyEnable];
    End;
End;
procedure CL3RegEditor.OnSetGrid;
Begin
    ExecSetGrid;
End;
procedure CL3RegEditor.OnSaveGrid;
Var
    i : Integer;
    pTbl:SL3REGION;
Begin
    for i:=1 to FsgGrid.RowCount-1 do
    Begin
     if FsgGrid.Cells[4,i]='' then break;
     pTbl.m_swID := i;
     GetGridRecord(pTbl);
     m_pDB.AddRegionTable(pTbl);
    End;
    ExecSetGrid;
End;

{
SL3REGION = packed record
     m_swID      : Integer;
     m_nRegionID : Integer;
     m_nRegNM    : string[100];
     m_sKSP      : string[5];
     m_sbyEnable : Byte;
     Item        : SL3ABONS;
    End;
}
procedure CL3RegEditor.GetGridRecord(var pTbl:SL3REGION);
Var
    i : Integer;
    str : String;
Begin
    i := pTbl.m_swID;
    with pTbl do Begin
     SetDefaultRow(i);
     m_swID      := StrToInt(FsgGrid.Cells[1,i]);
     m_nRegionID := StrToInt(FsgGrid.Cells[2,i]);
     m_nRegNM    := FsgGrid.Cells[3,i];
     m_sKSP      := FsgGrid.Cells[4,i];
     m_sbyEnable := m_nEsNoList.IndexOf(FsgGrid.Cells[5,i]);
    End;
End;
procedure CL3RegEditor.SetDefaultRow(i:Integer);
Begin
     if FsgGrid.Cells[1,i]='' then FsgGrid.Cells[1,i]  := '-1';
     if FsgGrid.Cells[2,i]='' then FsgGrid.Cells[2,i]  := IntToStr(GenIndex);
     if FsgGrid.Cells[3,i]='' then FsgGrid.Cells[3,i]  := 'Регион '+FsgGrid.Cells[2,i];
     if FsgGrid.Cells[4,i]='' then FsgGrid.Cells[4,i]  := '800'+FsgGrid.Cells[2,i];
     if FsgGrid.Cells[5,i]='' then FsgGrid.Cells[5,i]  := m_nEsNoList.Strings[1];
End;
procedure CL3RegEditor.ViewDefault;
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
procedure CL3RegEditor.ViewChild(nIndex:Integer);
Begin
    {
    if m_blCL2MetrEditor=False then
    if FChild<>Nil then
    Begin
     FChild.PMasterIndex := nIndex;
     if m_nRowIndex<>-1 then FChild.PTypeIndex := m_nTypeList.IndexOf(FsgGrid.Cells[5,m_nRowIndex]);
     FChild.ExecSetGrid;
    End;
    }
End;
function CL3RegEditor.FindFreeRow(nIndex:Integer):Integer;
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
procedure CL3RegEditor.OnAddRow;
Var
    nIndex : Integer;
Begin
    if m_nRowIndex<>-1 then
    Begin
     SetDefaultRow(m_nRowIndex);
     SetIndex(StrToInt(FsgGrid.Cells[m_nIDIndex,m_nRowIndex]));
    End else
    Begin
     nIndex := FindFreeRow(m_nIDIndex);
     SetDefaultRow(nIndex);
     SetIndex(StrToInt(FsgGrid.Cells[m_nIDIndex,nIndex]));
    End;
End;
procedure CL3RegEditor.OnCloneRow;
Var
    nIndex : Integer;
    pTbl   : SL3REGION;
Begin
    if m_nRowIndex<>-1 then
    if m_nRowIndex<=FindFreeRow(m_nIDIndex)-1 then
    Begin
     pTbl.m_swID   := m_nRowIndex;
     GetGridRecord(pTbl);
     pTbl.m_nRegionID := GenIndexSv;
     AddRecordToGrid(FindFreeRow(m_nIDIndex)-1,@pTbl);
    End;
End;
procedure CL3RegEditor.OnDelRow;
Var
    nFind : Integer;
Begin
    if m_nAmRecords=FindFreeRow(m_nIDIndex)-1 then
    Begin
     if m_nIndex<>-1 then
     Begin
      m_pDB.DelRegionTable(m_nIndex);
      SetEdit;
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
     End;
    End;
End;
procedure CL3RegEditor.OnDelAllRow;
Var
    i : Integer;
Begin
    m_pDB.DelRegionTable(-1);
    SetEdit;
    ExecSetGrid;
End;
procedure CL3RegEditor.OnClickGrid(Sender: TObject; ARow, ACol: Integer);
Begin
    m_nRowIndex   := -1;
    m_nRowIndexEx := -1;
    m_nColIndex   := ACol;
    if ARow>0 then Begin
     m_nRowIndex := ARow;
     m_nRowIndexEx := ARow;
     if FsgGrid.Cells[1,ARow]<>'' then
     Begin
      m_nIndex := StrToInt(FsgGrid.Cells[m_nIDIndex,ARow]);
      ViewChild(m_nIndex);
     End else m_nIndex := -1;
    End;
End;
//Init Layer
procedure CL3RegEditor.OnInitLayer;
Begin
    //ExecSetTree;
    ExecInitLayer;
End;
//Index Generator
function  CL3RegEditor.GenIndex:Integer;
Var
    i : Integer;
Begin
    for i:=0 to MAX_REGION do
    if m_blRegionIndex[i]=True then
    Begin
     Result := i;
     exit;
    End;
    Result := -1;
End;
function CL3RegEditor.GenIndexSv:Integer;
Begin
    Result := SetIndex(GenIndex);
End;
function CL3RegEditor.SetIndex(nIndex : Integer):Integer;
Begin
    m_blRegionIndex[nIndex] := False;
    Result := nIndex;
End;
Procedure CL3RegEditor.FreeIndex(nIndex : Integer);
Begin
    m_blRegionIndex[nIndex] := True;
End;
Procedure CL3RegEditor.FreeAllIndex;
Var
    i : Integer;
Begin
    for i:=0 to MAX_REGION do
    m_blRegionIndex[i] := True;
End;
procedure CL3RegEditor.OnExecute(Sender: TObject);
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
procedure CL3RegEditor.OnComboChandge(Sender: TObject; ACol, ARow,
               AItemIndex: Integer; ASelection: String);
Begin
     if ACol=4 then
     Begin
      //FsgGrid.Cells[3,ARow] := IntToStr(m_nCmdList.IndexOf(ASelection));
      FsgGrid.Cells[3,ARow] := IntToStr(m_nParams.Items[AItemIndex].m_swType);
      FsgGrid.Cells[8,ARow] := m_nSaveList.Strings[m_nParams.Items[AItemIndex].m_swIsGraph];
      FsgGrid.Cells[9,ARow] := m_nEsNoList.Strings[m_nParams.Items[AItemIndex].m_swActive];
      if FsgGrid.Cells[10,ARow]='' then FsgGrid.Cells[10,ARow]:= m_nCmdDirect.Strings[0];
      //m_nSaveList
     end;
End;
procedure CL3RegEditor.OnChannelGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
     OnGlGetCellColor(Sender,ARow,ACol,AState,ABrush,AFont);
end;
procedure CL3RegEditor.OnGetType(Sender: TObject; ACol, ARow: Integer;var AEditor: TEditorType);
begin
    with FsgGrid^ do
    case ACol of
     5:Begin
        AEditor := edComboList;
        combobox.items.loadfromfile(m_strCurrentDir+'Active.dat');
       End;
    end;
end;
function CL3RegEditor.GetComboIndex(cbCombo:TComboBox;str:String):Integer;
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
 