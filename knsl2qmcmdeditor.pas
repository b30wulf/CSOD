unit knsl2qmcmdeditor;
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,Messages,
  Graphics, Controls, Forms, Dialogs, Spin,
  Grids, BaseGrid, AdvGrid,utlbox,utlconst,utldatabase,knsl2treeloader,knsl5tracer,knsl5config;
type
    CL2QMCmdEditor = class
    Private
     FTreeModule    : PTTreeView;
     m_byTrState    : Byte;
     m_byTrEditMode : Byte;
     m_nPageIndex   : Integer;
     m_nIndex       : Integer;
     m_nMasterIndex : Integer;
     m_nRowIndex    : Integer;
     m_nColIndex    : Integer;
     m_nIDIndex     : Integer;
     m_strCurrentDir: String;
     FsgGrid        : PTAdvStringGrid;
     FcbCmdCombo    : PTComboBox;
     m_nCmdList     : TStringList;
     m_nCmdEsNo     : TStringList;
     m_nSaveList    : TStringList;
     FTreeLoader    : PCTreeLoader;
     m_nParams      : QM_PARAMS;
     m_nTehnoLen    : Integer;
     constructor Create;
     procedure InitCombo;
     procedure OnExecute(Sender: TObject);
     procedure ExecEditData;
     procedure ExecAddData;
     procedure ExecDelData;

     procedure AddRecordToGrid(nIndex:Integer;pTbl:PQM_COMMAND);
     procedure SetIndex(nIndex : Integer);
     function  GenIndex:Integer;
     procedure FreeIndex(nIndex : Integer);
     Procedure FreeAllIndex;
     procedure GetGridRecord(var pTbl:QM_COMMAND);
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
     procedure OnComboChandge(Sender: TObject; ACol, ARow,
               AItemIndex: Integer; ASelection: String);
     procedure OnClickGrid(Sender: TObject; ARow, ACol: Integer);
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
     procedure OnLoadAllCmd;
     procedure OnSetForAllQmParam;
     procedure SetEdit;
     procedure OpenInfo;
     procedure CloseInfo;
    Public
     property PTreeModule :PTTreeView      read FTreeModule    write FTreeModule;
     property PsgGrid :PTAdvStringGrid     read FsgGrid        write FsgGrid;
     property PcbCmdCombo :PTComboBox      read FcbCmdCombo    write FcbCmdCombo;
     property PPageIndex  :Integer         read m_nPageIndex   write m_nPageIndex;
     property PIndex      :Integer         read m_nIndex       write m_nIndex;
     property PMasterIndex:Integer         read m_nMasterIndex write m_nMasterIndex;
     property PTreeLoader :PCTreeLoader    read FTreeLoader    write FTreeLoader;
    End;
implementation
constructor CL2QMCmdEditor.Create;
Begin

End;
{
     m_swID      : Word;
     m_swType    : Word;
     m_swCMDID   : Word;
     m_sName     : String[40];
     m_sExpress  : String[40];
     m_swSpec0   : Word;
     m_swSpec1   : Word;
     m_swSpec2   : Word;
     m_sbyEnable : Byte;
     m_sComment  : String[40];
}


destructor CL2QMCmdEditor.Destroy;
begin
  if m_nCmdEsNo <> nil then FreeAndNil(m_nCmdEsNo);
  if m_nSaveList <> nil then FreeAndNil(m_nSaveList);
  if m_nCmdList <> nil then FreeAndNil(m_nCmdList);
  inherited;
end;

procedure CL2QMCmdEditor.Init;
Var
    i : Integer;
Begin
    m_strCurrentDir := ExtractFilePath(Application.ExeName) + '\\Settings\\';
    for i:=0 to MAX_MTYPE do m_blMTypeIndex[i] := True;
    m_nCmdList  := TStringList.Create;
    m_nCmdEsNo  := TStringList.Create;
    m_nSaveList := TStringList.Create;
    m_nCmdList.LoadFromFile(m_strCurrentDir+'CommandType.dat');
    m_nCmdEsNo.LoadFromFile(m_strCurrentDir+'Active.dat');
    m_nSaveList.LoadFromFile(m_strCurrentDir+'StateSaveParam.dat');
    m_nRowIndex         := -1;
    m_nColIndex         := -1;
    m_nIDIndex          := 1;
    FsgGrid.Color       := KNS_NCOLOR;
    FsgGrid.ColCount    := 12;
    FsgGrid.RowCount    := 100;
    FsgGrid.Cells[0,0]  := '�/T';
    FsgGrid.Cells[1,0]  := 'ID';
    FsgGrid.Cells[2,0]  := '������ ID';
    FsgGrid.Cells[3,0]  := '����. ID';
    FsgGrid.Cells[4,0]  := '��������';
    FsgGrid.Cells[5,0]  := '������������ �1';
    FsgGrid.Cells[6,0]  := '������������ �2';
    FsgGrid.Cells[7,0]  := '������������ �3';
    FsgGrid.Cells[8,0]  := '��� ��������';
    FsgGrid.Cells[9,0]  := '����������';
    FsgGrid.Cells[10,0] := '��� �������';
    FsgGrid.Cells[11,0] := '��� ������';
    //CloseInfo;
    FsgGrid.ColWidths[0]:= 30;
    FsgGrid.ColWidths[1]:= 1;
    FsgGrid.ColWidths[2]:= 1;
    FsgGrid.ColWidths[3]:= 1;
    FsgGrid.ColWidths[4]:= 270;
    m_nTehnoLen := 273;
    //SetHigthGrid(FsgGrid^,20);
    //ExecSetTree;
    //ExpandTree(FTreeModule^,'������');
    ExecSetGrid;
End;
procedure CL2QMCmdEditor.OpenInfo;
Begin
    FsgGrid.ColWidths[0]:= 30;
    FsgGrid.ColWidths[1]:= 40;
    FsgGrid.ColWidths[2]:= 40;
    FsgGrid.ColWidths[3]:= 40;
    FsgGrid.ColWidths[4]:= 270;
    m_nTehnoLen := 40+40+40+270;
    OnFormResize;
End;
procedure CL2QMCmdEditor.CloseInfo;
Begin
    FsgGrid.ColWidths[0]:= 30;
    FsgGrid.ColWidths[1]:= 1;
    FsgGrid.ColWidths[2]:= 1;
    FsgGrid.ColWidths[3]:= 1;
    FsgGrid.ColWidths[4]:= 270;
    m_nTehnoLen := 273;
    OnFormResize;
End;
procedure CL2QMCmdEditor.InitCombo;
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
{
      m_swID      := FieldByName('m_swID').AsInteger;
      m_swType    := FieldByName('m_swType').AsInteger;
      m_sName     := FieldByName('m_sName').AsString;
      m_sEName    := FieldByName('m_sEName').AsString;
      m_sEMet     := FieldByName('m_sEMet').AsString;
      m_swSvPeriod:= FieldByName('m_swSvPeriod').AsInteger;
      m_sblTarif  := FieldByName('m_sblTarif').AsInteger;
      m_swActive  := FieldByName('m_swActive').AsInteger;
      m_swStatus  := FieldByName('m_swStatus').AsInteger;
      m_swIsGraph := FieldByName('m_swIsGraph').AsInteger;
}
procedure CL2QMCmdEditor.SetEdit;
Begin
     m_nRowIndex         := -1;
End;
procedure CL2QMCmdEditor.OnLoadAllCmd;
Var
    i : Integer;
Begin
     InitCombo;
     for i:=1 to m_nParams.Count-1 do
     Begin
      with m_nParams.Items[i] do
      Begin
       FsgGrid.Cells[0,i]  := IntToStr(i);
       FsgGrid.Cells[1,i]  := '';
       FsgGrid.Cells[2,i]  := IntToStr(m_nMasterIndex);
       FsgGrid.Cells[3,i]  := IntToStr(m_swType);
       FsgGrid.Cells[4,i]  := m_sName;
       if FsgGrid.Cells[5,i]=''  then FsgGrid.Cells[5,i]  := '0';
       if FsgGrid.Cells[6,i]=''  then FsgGrid.Cells[6,i]  := '0';
       if FsgGrid.Cells[7,i]=''  then FsgGrid.Cells[7,i]  := '0';
       //if FsgGrid.Cells[8,i]=''  then FsgGrid.Cells[8,i]  := m_nSaveList.Strings[m_swIsGraph];
       FsgGrid.Cells[8,i]  := m_nSaveList.Strings[m_swIsGraph];
       if FsgGrid.Cells[9,i]=''  then FsgGrid.Cells[9,i]  := m_nCmdEsNo.Strings[m_swActive];
       if FsgGrid.Cells[10,i]='' then FsgGrid.Cells[10,i] := m_nCmdDirect.Strings[0];
      End;
     End;
End;
procedure CL2QMCmdEditor.OnSetForAllQmParam;
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
procedure CL2QMCmdEditor.SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
Var
    i : Integer;
Begin
   // for i:=0 to sgGrid.RowCount-1 do Begin sgGrid.Cells[0,i+1] := IntToStr(i+1); sgGrid.RowHeights[i]:= nHigth;End;
End;
procedure CL2QMCmdEditor.OnFormResize;
Var
    i : Integer;
Begin
    if Assigned(FsgGrid)=True then
    for i:=5 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-(m_nTehnoLen)-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1-4));
End;
//Edit Add Del Request
procedure CL2QMCmdEditor.OnEditNode;
begin
end;
procedure CL2QMCmdEditor.OnAddNode;
begin
end;
procedure CL2QMCmdEditor.OnDeleteNode;
Begin
End;
//Edit Add Del Execute
procedure CL2QMCmdEditor.ExecSetEditData(nIndex:Integer);
Begin
    TraceL(1,0,'ExecSetEditData.');
End;
procedure CL2QMCmdEditor.ExecEditData;
Begin
    TraceL(1,0,'ExecEditData.');
End;
procedure CL2QMCmdEditor.ExecAddData;
Begin
    TraceL(1,0,'ExecAddData.');
End;
procedure CL2QMCmdEditor.ExecDelData;
Begin
    TraceL(1,0,'ExecDelData.');
End;
procedure CL2QMCmdEditor.ExecInitLayer;
Begin
    TraceL(1,0,'ExecInitLayer.');
    //mL2Module.Init;
End;
//Tree Reload
procedure CL2QMCmdEditor.ExecSetTree;
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
procedure CL2QMCmdEditor.ExecSetGrid;
Var
    pTbl : QM_COMMANDS;
    i : Integer;
Begin
    FsgGrid.ClearNormalCells;
    //FsgGrid.TopRow := 1;
    //FreeAllIndex;
    if m_pDB.GetQMCommandsTable(m_nMasterIndex,pTbl)=True then
    Begin
     for i:=0 to pTbl.m_swAmCommandType-1 do
     Begin
      AddRecordToGrid(i,@pTbl.m_sCommandType[i]);
     End;
    End;
    
End;
procedure CL2QMCmdEditor.AddRecordToGrid(nIndex:Integer;pTbl:PQM_COMMAND);
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
     FsgGrid.Cells[3,nY]  := IntToStr(m_swCMDID);
     FsgGrid.Cells[4,nY]  := m_nCommandList.Strings[m_swCMDID];
     //m_nCommandList
     //FsgGrid.Cells[4,nY]  := m_sName;
     FsgGrid.Cells[5,nY]  := IntToStr(m_swSpec0);
     FsgGrid.Cells[6,nY]  := IntToStr(m_swSpec1);
     FsgGrid.Cells[7,nY]  := IntToStr(m_swSpec2);
     FsgGrid.Cells[8,nY]  := m_nSaveList.Strings[m_sblSaved];
     FsgGrid.Cells[9,nY]  := m_nCmdEsNo.Strings[m_sbyEnable];
     FsgGrid.Cells[10,nY] := m_nCmdDirect.Strings[m_sbyDirect];
     FsgGrid.Cells[11,nY] := m_nDataType.Strings[m_snDataType];
    End;
End;
procedure CL2QMCmdEditor.OnSetGrid;
Begin
    ExecSetGrid;
End;
procedure CL2QMCmdEditor.OnSaveGrid;
Var
    i : Integer;
    pTbl:QM_COMMAND;
Begin
    for i:=1 to FsgGrid.RowCount-1 do
    Begin
     if FsgGrid.Cells[4,i]='' then break;
     pTbl.m_swID := i;
     GetGridRecord(pTbl);
     m_pDB.AddQMCommandTable(pTbl);
    End;
    ExecSetGrid;
End;
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
procedure CL2QMCmdEditor.GetGridRecord(var pTbl:QM_COMMAND);
Var
    i : Integer;
    str : String;
Begin
    i := pTbl.m_swID;
    with pTbl do Begin
     SetDefaultRow(i);
     m_swID      := StrToInt(FsgGrid.Cells[1,i]);
     m_swType    := StrToInt(FsgGrid.Cells[2,i]);
     m_swCMDID   := StrToInt(FsgGrid.Cells[3,i]);
     m_sName     := FsgGrid.Cells[4,i];
     m_swSpec0   := StrToInt(FsgGrid.Cells[5,i]);
     m_swSpec1   := StrToInt(FsgGrid.Cells[6,i]);
     m_swSpec2   := StrToInt(FsgGrid.Cells[7,i]);
     m_sblSaved  := m_nSaveList.IndexOf(FsgGrid.Cells[8,i]);
     m_sbyEnable := m_nCmdEsNo.IndexOf(FsgGrid.Cells[9,i]);
     m_sbyDirect := m_nCmdDirect.IndexOf(FsgGrid.Cells[10,i]);
     m_snDataType:= m_nDataType.IndexOf(FsgGrid.Cells[11,i]);
    End;
End;
procedure CL2QMCmdEditor.SetDefaultRow(i:Integer);
Begin
     if FsgGrid.Cells[1,i]='' then FsgGrid.Cells[1,i]  := '-1';
     if FsgGrid.Cells[2,i]='' then FsgGrid.Cells[2,i]  := IntToStr(m_nMasterIndex);
     if FsgGrid.Cells[3,i]='' then FsgGrid.Cells[3,i]  := '0';
     if FsgGrid.Cells[4,i]='' then FsgGrid.Cells[4,i]  := 'X Command';
     if FsgGrid.Cells[5,i]='' then FsgGrid.Cells[5,i]  := '0';
     if FsgGrid.Cells[6,i]='' then FsgGrid.Cells[6,i]  := '0';
     if FsgGrid.Cells[7,i]='' then FsgGrid.Cells[7,i]  := '0';
     if FsgGrid.Cells[8,i]='' then FsgGrid.Cells[8,i]  := m_nSaveList.Strings[0];
     if FsgGrid.Cells[9,i]='' then FsgGrid.Cells[9,i]  := m_nCmdEsNo.Strings[1];
     if FsgGrid.Cells[10,i]=''then FsgGrid.Cells[10,i] := m_nCmdDirect.Strings[0];
     if FsgGrid.Cells[11,i]=''then FsgGrid.Cells[11,i] := m_nDataType.Strings[DTP_DBL5];

End;
procedure CL2QMCmdEditor.OnClickGrid(Sender: TObject; ARow, ACol: Integer);
Begin
    m_nRowIndex := -1;
    if ARow>0 then Begin
     m_nRowIndex := ARow;
     m_nColIndex := ACol;
     if FsgGrid.Cells[m_nIDIndex,ARow]<>'' then
     Begin
      m_nIndex := StrToInt(FsgGrid.Cells[1,ARow]);
      //ViewChild(m_nIndex);
     End else m_nIndex := -1;
    End;
End;
procedure CL2QMCmdEditor.OnDelRow;
Var
    nIndex : Integer;
Begin
    m_pDB.DelQMCommandTable(m_nMasterIndex,m_nIndex);
    ExecSetGrid;
End;
procedure CL2QMCmdEditor.OnDelAllRow;
Begin
    m_pDB.DelQMCommandTable(m_nMasterIndex,-1);
    //FreeAllIndex;
    ExecSetGrid;
End;
//Init Layer
procedure CL2QMCmdEditor.OnInitLayer;
Begin
    //ExecSetTree;
    ExecInitLayer;
End;
//Index Generator
function  CL2QMCmdEditor.GenIndex:Integer;
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
Procedure CL2QMCmdEditor.SetIndex(nIndex : Integer);
Begin
    m_blMTypeIndex[nIndex] := False;
End;
Procedure CL2QMCmdEditor.FreeIndex(nIndex : Integer);
Begin
    m_blMTypeIndex[nIndex] := True;
End;
Procedure CL2QMCmdEditor.FreeAllIndex;
Var
    i : Integer;
Begin
    for i:=0 to MAX_MTYPE do
    m_blMTypeIndex[i] := True;
End;
procedure CL2QMCmdEditor.OnExecute(Sender: TObject);
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
procedure CL2QMCmdEditor.OnComboChandge(Sender: TObject; ACol, ARow,
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
procedure CL2QMCmdEditor.OnChannelGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
     OnGlGetCellColor(Sender,ARow,ACol,AState,ABrush,AFont);
end;
procedure CL2QMCmdEditor.OnChannelGetCellType(Sender: TObject; ACol, ARow: Integer;var AEditor: TEditorType);
begin
    with FsgGrid^ do
    case ACol of
     4:Begin
        AEditor := edComboList;
        InitCombo;
        //combobox.items.loadfromfile(m_strCurrentDir+'CommandType.dat');
       End;
     8:Begin
        AEditor := edComboList;
        combobox.items.loadfromfile(m_strCurrentDir+'StateSaveParam.dat');
       End;
     9:Begin
        AEditor := edComboList;
        combobox.items.loadfromfile(m_strCurrentDir+'Active.dat');
       End;
     10:Begin
        AEditor := edComboList;
        combobox.items.loadfromfile(m_strCurrentDir+'CmdDirection.dat');
       End;
     11:Begin
        AEditor := edComboList;
        combobox.items.loadfromfile(m_strCurrentDir+'DataType.dat');
       End;
    end;
end;
function CL2QMCmdEditor.GetComboIndex(cbCombo:TComboBox;str:String):Integer;
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
