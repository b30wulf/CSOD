unit knsl3ConnEditor;
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
    CL3ConnEditor = class
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
     m_blIsControl  : Boolean;
     m_strCurrentDir: String;
     FsgGrid        : PTAdvStringGrid;
     FsgCGrid       : PTAdvStringGrid;
     FcbCmdCombo    : PTComboBox;
     FChild         : CL2QMCmdEditor;
     FTreeLoader    : PCTreeLoader;
     //m_pPTable      : SL1INITITAG;
     m_nCID         : TStringList;
     m_nSaveList    : TStringList;
     m_nCtrChList   : TStringList;
     m_nTehnoLen    : Integer;
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

     procedure AddRecordToGrid(nIndex:Integer;pTbl:PSL3CONNTBL);
     function  SetIndex(nIndex : Integer):Integer;
     function  GenIndex:Integer;
     function  GenIndexSv:Integer;
     procedure FreeIndex(nIndex : Integer);
     Procedure FreeAllIndex;
     procedure GetGridRecord(var pTbl:SL3CONNTBL);
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
     procedure OnComboChandge(Sender: TObject; ACol, ARow,
               AItemIndex: Integer; ASelection: String);
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
constructor CL3ConnEditor.Create;
Begin

End;
{
SL3CONNTBL = packed record
     m_swID        : Integer;
     m_swCNID      : Integer;
     m_swCPortID   : Integer;
     m_sConnString : String[150];
     m_sLogin      : String[50];
     m_sPassword   : String[50];
     m_sbyEnable   : Byte;
    End;
    PSL3CONNTBL =^ SL3CONNTBL;
}

destructor CL3ConnEditor.Destroy;
begin
  if m_nCID <> nil then FreeAndNil(m_nCID);
  if m_nCtrChList <> nil then FreeAndNil(m_nCtrChList);
  inherited;
end;

procedure CL3ConnEditor.Init;
Var
    i : Integer;
Begin
    m_nCID       := TStringList.Create;
    m_nCtrChList := TStringList.Create;
    m_strCurrentDir := ExtractFilePath(Application.ExeName) + '\\Settings\\';
    for i:=0 to MAX_CTYPE do m_blConnTypeIndex[i] := True;
    m_nRowIndex         := -1;
    m_nRowIndexEx       := 2;
    m_nIDIndex          := 2;
    FsgGrid.Color       := KNS_NCOLOR;
    FsgGrid.ColCount    := 14;
    FsgGrid.RowCount    := 70;
    FsgGrid.Cells[0,0]  := '№/T';
    FsgGrid.Cells[1,0]  := 'ID';
    FsgGrid.Cells[2,0]  := 'Канал';
    FsgGrid.Cells[3,0]  := 'Порт ID';
    FsgGrid.Cells[4,0]  := 'Порт управления';
    FsgGrid.Cells[5,0]  := 'Расположение';
    FsgGrid.Cells[6,0]  := 'Режим сети';
    FsgGrid.Cells[7,0]  := 'Название';
    FsgGrid.Cells[8,0]  := 'Строка соединения';
    FsgGrid.Cells[9,0]  := 'IP Адрес';
    FsgGrid.Cells[10,0] := 'IP Порт';
    FsgGrid.Cells[11,0] := 'Пароль AD';
    FsgGrid.Cells[12,0] := 'Пароль SA';
    FsgGrid.Cells[13,0] := 'Акт.';
    FsgGrid.ColWidths[0]:= 30;
    FsgGrid.ColWidths[1]:= 0;
    FsgGrid.ColWidths[2]:= 0;
    FsgGrid.ColWidths[3]:= 0;
    FsgGrid.ColWidths[4]:= 0;
    FsgGrid.ColWidths[5]:= 0;
    FsgGrid.ColWidths[6]:= 0;
    FsgGrid.ColWidths[7]:= 150;
    FsgGrid.ColWidths[8]:= 500;
    FsgGrid.ColWidths[9] := 0;
    FsgGrid.ColWidths[10]:= 0;
    FsgGrid.ColWidths[11]:= 0;
    FsgGrid.ColWidths[12]:= 0;
    m_nTehnoLen         := 3*0+2*0+0+150+500;
    //SetHigthGrid(FsgGrid^,20);
    InitCombo;
    ExecSetGrid;
End;
procedure CL3ConnEditor.OpenInfo;
Begin
    FsgGrid.ColWidths[0]:= 30;
    FsgGrid.ColWidths[1]:= 40;
    FsgGrid.ColWidths[2]:= 40;
    FsgGrid.ColWidths[3]:= 40;
    FsgGrid.ColWidths[4]:= 70;
    FsgGrid.ColWidths[5]:= 70;
    FsgGrid.ColWidths[6]:= 60;
    FsgGrid.ColWidths[7]:= 150;
    FsgGrid.ColWidths[8]:= 500;
    FsgGrid.ColWidths[9] := 0;
    FsgGrid.ColWidths[10]:= 0;
    FsgGrid.ColWidths[11]:= 0;
    FsgGrid.ColWidths[12]:= 0;
    m_nTehnoLen         := 3*40+2*70+60+150+500;
    OnFormResize;
End;
procedure CL3ConnEditor.CloseInfo;
Begin
    FsgGrid.ColWidths[0]:= 30;
    FsgGrid.ColWidths[1]:= 0;
    FsgGrid.ColWidths[2]:= 0;
    FsgGrid.ColWidths[3]:= 0;
    FsgGrid.ColWidths[4]:= 0;
    FsgGrid.ColWidths[5]:= 0;
    FsgGrid.ColWidths[6]:= 0;
    FsgGrid.ColWidths[7]:= 150;
    FsgGrid.ColWidths[8]:= 500;
    FsgGrid.ColWidths[9] := 0;
    FsgGrid.ColWidths[10]:= 0;
    FsgGrid.ColWidths[11]:= 0;
    FsgGrid.ColWidths[12]:= 0;
    m_nTehnoLen         := 3*0+2*0+0+150+500;
    OnFormResize;
End;
procedure CL3ConnEditor.SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
Var
    i : Integer;
Begin
  //  for i:=0 to sgGrid.RowCount-1 do Begin sgGrid.Cells[0,i+1] := IntToStr(i+1); sgGrid.RowHeights[i]:= nHigth;End;
End;
procedure CL3ConnEditor.OnFormResize;
Var
    i : Integer;
Begin
    for i:=13 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-m_nTehnoLen-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1-12));
    if FChild<>Nil then FChild.OnFormResize;
End;
{
procedure CL1Editor.ExecSetGrid;
Var
    pTbl : SL1INITITAG;
    i : Integer;
Begin
    FsgGrid.ClearNormalCells;
    if m_pDB.GetL1Table(pTbl)=True then
    Begin
     m_nAmRecords := pTbl.Count;
     for i:=0 to pTbl.Count-1 do
     Begin
      SetIndex(pTbl.Items[i].m_sbyPortID);
      AddRecordToGrid(i,@pTbl.Items[i]);
     End;
     //ViewChild(StrToInt(pTbl.Items[0].m_sbyPortID));
    End;
End;
}
procedure CL3ConnEditor.InitCombo;
Var
    i         : Integer;
    m_pPTable : SL1INITITAG;
Begin
    m_blIsControl := False;
    if m_pDB.GetCtrConnTable(m_pPTable) then
    Begin
     m_blIsControl := True;
     FsgGrid.Combobox.Items.Clear;
     m_nCtrChList.Clear;
     m_nCID.Clear;
     for i:=0 to m_pPTable.Count-0 do
     Begin
      if i=0 then
      Begin
       FsgGrid.Combobox.Items.Add('Local');
       m_nCtrChList.Add('Local');
       m_nCID.Add('0');
      End else
      Begin
       FsgGrid.Combobox.Items.Add(m_pPTable.Items[i-1].m_schName);
       m_nCtrChList.Add(m_pPTable.Items[i-1].m_schName);
       m_nCID.Add(IntToStr(m_pPTable.Items[i-1].m_sbyPortID));
      End;
     End;
    End;
End;
//Edit Add Del Request
procedure CL3ConnEditor.OnEditNode;
begin
end;
procedure CL3ConnEditor.OnAddNode;
begin
end;
procedure CL3ConnEditor.OnDeleteNode;
Begin
End;
//Edit Add Del Execute
procedure CL3ConnEditor.ExecSetEditData(nIndex:Integer);
Begin
    TraceL(1,0,'ExecSetEditData.');
End;
procedure CL3ConnEditor.ExecEditData;
Begin
    TraceL(1,0,'ExecEditData.');
End;
procedure CL3ConnEditor.ExecAddData;
Begin
    TraceL(1,0,'ExecAddData.');
End;
procedure CL3ConnEditor.ExecDelData;
Begin
    TraceL(1,0,'ExecDelData.');
End;
procedure CL3ConnEditor.ExecInitLayer;
Begin
    TraceL(1,0,'ExecInitLayer.');
    mL2Module.Init;
End;
//Tree Reload
procedure CL3ConnEditor.ExecSetTree;
Begin
    TraceL(1,0,'ExecSetTree.');
    FTreeLoader.LoadTree;
End;
//Grid Routine
procedure CL3ConnEditor.OnLoadFromFile;
Var
    i : Integer;
Begin
    m_nCommandList.Clear;
    m_nCommandList.LoadFromFile(m_strCurrentDir+'CommandType.dat');
    for i:=0 to m_nCommandList.Count-1 do
    Begin
     FsgGrid.Cells[3,i+1] := m_nCommandList.Strings[i];
    End;
End;
procedure CL3ConnEditor.ExecSelRowGrid;
Begin
    FsgGrid.SelectRows(FindRow(IntToStr(m_nIndex)),1);
    FsgGrid.Refresh;
    ViewChild(m_nIndex);
End;
function CL3ConnEditor.FindRow(str:String):Integer;
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
procedure CL3ConnEditor.ViewChild(nIndex:Integer);
Begin
    if FChild<>Nil then
    Begin
     FChild.PMasterIndex := nIndex;
     FChild.ExecSetGrid;
    End;
End;
procedure CL3ConnEditor.ExecSetGrid;
Var
    pTbl : SL3CONNTBLS;
    i : Integer;
Begin
    FsgGrid.ClearNormalCells;
    if m_pDB.GetConnTable(pTbl)=True then
    Begin
     m_nAmRecords := pTbl.Count;
     for i:=0 to pTbl.Count-1 do
     Begin
      SetIndex(pTbl.Items[i].m_swCNID);
      AddRecordToGrid(i,@pTbl.Items[i]);
     End;
     ViewDefault;
    End;
End;
procedure CL3ConnEditor.ViewDefault;
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

procedure CL3ConnEditor.AddRecordToGrid(nIndex:Integer;pTbl:PSL3CONNTBL);
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
     FsgGrid.Cells[2,nY]  := IntToStr(m_swCNID);
     FsgGrid.Cells[3,nY]  := IntToStr(m_swCPortID);
     if m_blIsControl=True  then FsgGrid.Cells[4,nY]  := m_nCtrChList.Strings[m_swCPortID];
     if m_blIsControl=False then FsgGrid.Cells[4,nY]  := '';
     FsgGrid.Cells[5,nY]  := m_nMeterLocation.Strings[m_swLocation];
     FsgGrid.Cells[6,nY]  := m_nNetMode.Strings[m_swNetMode];
     FsgGrid.Cells[7,nY]  := m_sName;
     FsgGrid.Cells[8,nY]  := m_sConnString;
     FsgGrid.Cells[9,nY]  := m_sLogin;
     FsgGrid.Cells[10,nY] := m_sPassword;
     FsgGrid.Cells[11,nY] := m_sPasswordL2;
     FsgGrid.Cells[12,nY] := m_sPasswordL3;
     FsgGrid.Cells[13,nY] := m_nActiveList.Strings[m_sbyEnable];
    End;
End;
procedure CL3ConnEditor.OnSetGrid;
Begin
    ExecSetGrid;
End;
procedure CL3ConnEditor.OnSaveGrid;
Var
    i : Integer;
    pTbl:SL3CONNTBL;
Begin
    for i:=1 to FsgGrid.RowCount-1 do
    Begin
     if FsgGrid.Cells[3,i]='' then break;
     pTbl.m_swID := i;
     GetGridRecord(pTbl);
     if m_pDB.AddConnTable(pTbl)=True then SetIndex(pTbl.m_swCNID);
    End;
    ExecSetGrid;
End;
function CL3ConnEditor.FindFreeRow(nIndex:Integer):Integer;
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
procedure CL3ConnEditor.GetGridRecord(var pTbl:SL3CONNTBL);
Var
    i : Integer;
    str : String;
Begin
    i := pTbl.m_swID;
    with pTbl do Begin
     SetDefaultRow(i);
     m_swID       := StrToInt(FsgGrid.Cells[1,i]);
     m_swCNID     := StrToInt(FsgGrid.Cells[2,i]);
     m_swCPortID  := StrToInt(FsgGrid.Cells[3,i]);
     m_swCPortID  := m_nCtrChList.IndexOf(FsgGrid.Cells[4,i]);
     m_swLocation := m_nMeterLocation.IndexOf(FsgGrid.Cells[5,i]);
     m_swNetMode  := m_nNetMode.IndexOf(FsgGrid.Cells[6,i]);
     m_sName      := FsgGrid.Cells[7,i];
     m_sConnString:= FsgGrid.Cells[8,i];
     m_sLogin     := FsgGrid.Cells[9,i];
     m_sPassword  := FsgGrid.Cells[10,i];
     m_sPasswordL2:= FsgGrid.Cells[11,i];
     m_sPasswordL3:= FsgGrid.Cells[12,i];
     m_sbyEnable  := m_nActiveList.IndexOf(FsgGrid.Cells[13,i]);
    End;
End;
procedure CL3ConnEditor.OnAddRow;
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
procedure CL3ConnEditor.OnCloneRow;
Var
    nIndex : Integer;
    pTbl   : SL3CONNTBL;
Begin
    if m_nRowIndex<>-1 then
    if m_nRowIndex<=FindFreeRow(3)-1 then
    Begin
     pTbl.m_swID   := m_nRowIndex;
     GetGridRecord(pTbl);
     pTbl.m_swCNID := GenIndexSv;
     AddRecordToGrid(FindFreeRow(3)-1,@pTbl);
    End;
End;
{
SL3CONNTBL = packed record
     m_swID        : Integer;
     m_swCNID      : Integer;
     m_swCPortID   : Integer;
     m_sConnString : String[150];
     m_sLogin      : String[50];
     m_sPassword   : String[50];
     m_sbyEnable   : Byte;
    End;
}
procedure CL3ConnEditor.SetDefaultRow(i:Integer);
Var
    dtTM   : TDateTime;
    wValue : Word;
Begin
    wValue := 0;
    DecodeDate(dtTM,wValue,wValue,wValue);
    DecodeTime(dtTM,wValue,wValue,wValue,wValue);
    if FsgGrid.Cells[1,i]='' then FsgGrid.Cells[1,i]  := '-1';
    if FsgGrid.Cells[2,i]='' then FsgGrid.Cells[2,i]  := IntToStr(GenIndex);
    if FsgGrid.Cells[3,i]='' then FsgGrid.Cells[3,i]  := '0';
    if FsgGrid.Cells[4,i]='' then FsgGrid.Cells[4,i]  := m_nCtrChList.Strings[0];
    if FsgGrid.Cells[5,i]='' then FsgGrid.Cells[5,i]  := m_nMeterLocation.Strings[0];
    if FsgGrid.Cells[6,i]='' then FsgGrid.Cells[6,i]  := m_nNetMode.Strings[0];
    if FsgGrid.Cells[7,i]='' then FsgGrid.Cells[7,i]  := 'Локальное подключение';
    if FsgGrid.Cells[8,i]='' then FsgGrid.Cells[8,i]  := 'DBProvider=Provider=MSDASQL.1;Password=masterkey;Persist Security Info=True;User ID=SYSDBA;Data Source=Firebird1';
    if FsgGrid.Cells[9,i]='' then FsgGrid.Cells[9,i]  := 'Superadmin';
    if FsgGrid.Cells[10,i]=''then FsgGrid.Cells[10,i] := '1';
    if FsgGrid.Cells[11,i]=''then FsgGrid.Cells[11,i] := '1';
    if FsgGrid.Cells[12,i]=''then FsgGrid.Cells[12,i] := '1';
    if FsgGrid.Cells[13,i]=''then FsgGrid.Cells[13,i] := m_nActiveList.Strings[1];
End;
procedure CL3ConnEditor.OnClickGrid(Sender: TObject; ARow, ACol: Integer);
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
procedure CL3ConnEditor.OnDelRow;
Var
    nFind : Integer;
Begin
    if m_nAmRecords=FindFreeRow(3)-1 then
    Begin
     if m_nIndex<>-1 then
     Begin
      FreeAllIndex;
      m_pDB.DelConnTable(m_nIndex);
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
procedure CL3ConnEditor.OnDelAllRow;
Begin
    m_pDB.DelConnTable(-1);
    FreeAllIndex;
    ExecSetGrid;
End;
//Init Layer
procedure CL3ConnEditor.OnInitLayer;
Begin
    //ExecSetTree;
    ExecInitLayer;
End;
//Index Generator
function  CL3ConnEditor.GenIndex:Integer;
Var
    i : Integer;
Begin
    for i:=0 to MAX_CTYPE do
    if m_blConnTypeIndex[i]=True then
    Begin
     Result := i;
     exit;
    End;
    Result := -1;
End;
function  CL3ConnEditor.GenIndexSv:Integer;
Begin
    Result := SetIndex(GenIndex);
End;
function CL3ConnEditor.SetIndex(nIndex : Integer):Integer;
Begin
    m_blConnTypeIndex[nIndex] := False;
    Result := nIndex;
End;
Procedure CL3ConnEditor.FreeIndex(nIndex : Integer);
Begin
    m_blConnTypeIndex[nIndex] := True;
End;
Procedure CL3ConnEditor.FreeAllIndex;
Var
    i : Integer;
Begin
    for i:=0 to MAX_CTYPE do
    m_blConnTypeIndex[i] := True;
End;
procedure CL3ConnEditor.OnExecute(Sender: TObject);
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
procedure CL3ConnEditor.OnComboChandge(Sender: TObject; ACol, ARow,
               AItemIndex: Integer; ASelection: String);
Begin
     if ACol=4 then
     Begin
     if ARow>0 then
      FsgGrid.Cells[3,ARow] := m_nCID.Strings[AItemIndex];
     End;
End;
//Color And Control
procedure CL3ConnEditor.OnChannelGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
    OnGlGetCellColor(Sender,ARow,ACol,AState,ABrush,AFont);
end;
procedure CL3ConnEditor.OnChannelGetCellType(Sender: TObject; ACol, ARow: Integer;var AEditor: TEditorType);
begin
    with FsgGrid^ do
    case ACol of
     4:Begin
        AEditor := edComboList;
        //combobox.items.loadfromfile(m_strCurrentDir+'SavePeriod.dat');
        InitCombo;
       End;                    
     5:Begin
        AEditor := edComboList;
        combobox.items.loadfromfile(m_strCurrentDir+'MeterLocation.dat');
       End;
     6:Begin
        AEditor := edComboList;
        combobox.items.loadfromfile(m_strCurrentDir+'NetMode.dat');
       End;
    13:Begin
        AEditor := edComboList;
        combobox.items.loadfromfile(m_strCurrentDir+'Active.dat');
       End;
    end;
end;
function CL3ConnEditor.GetComboIndex(cbCombo:TComboBox;str:String):Integer;
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
