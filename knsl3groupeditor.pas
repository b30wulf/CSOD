unit knsl3groupeditor;
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,Messages,
  Graphics, Controls, Forms, Dialogs, Spin,
  Grids, BaseGrid, AdvGrid,utlbox,utlconst,utldatabase,knsl1module,
  knsl2module,knsl3vmetereditor,knsl2treeloader,knsl5tracer,knsl5config,knseditexpr,knsl2qmcmdeditor;
type

    CL3GroupEditor = class
    Private
     FTreeModule    : PTTreeView;
     m_byTrState    : Byte;
     m_byTrEditMode : Byte;
     m_nIDIndex     : Integer;
     m_nRowIndex    : Integer;
     m_nRowIndexEx    : Integer;
     m_nAmRecords   : Integer;
     m_nPageIndex   : Integer;
     m_nIndex       : Integer;
     m_nMasterIndex : Integer;
     m_strCurrentDir: String;
     FsgGrid        : PTAdvStringGrid;
     FChild         : CL3VMeterEditor;
     FTreeLoader    : PCTreeLoader;

     m_nGroupIndex  : Integer;
     m_nCmdList     : TStringList;
     blOnClickfrom  : boolean;
     FsgGridChild   : PTAdvStringGrid;
     m_nPlaneList   : TStringList;
     m_nTehnoLen    : Integer;
     
     constructor Create;
     function  FindRow(str:String):Integer;
     procedure ViewChild(nIndex:Integer);
     procedure ViewDefault;
     procedure OnExecute(Sender: TObject);
     procedure ExecEditData;
     procedure ExecAddData;
     procedure ExecDelData;

     procedure AddRecordToGrid(nIndex:Integer;pTbl:PSL3GROUPTAG);
     function  FindFreeRow(nIndex:Integer):Integer;
     procedure SetDefaultRow(i:Integer);
     procedure GetGridRecord(var pTbl:SL3GROUPTAG);
     function  GetComboIndex(cbCombo:TComboBox;str:String):Integer;
     procedure SendMSG(byBox,byFor,byType:Byte);
     procedure InitComboPl;
    Public
     procedure Init;
     destructor Destroy; override;
     procedure ExecSelRowGrid;
     procedure OnFormResize;
      procedure OnMDownGE(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
     procedure OnChannelGetCellColor(Sender: TObject; ARow,
               ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
     procedure OnChannelGetCellType(Sender: TObject; ACol,
               ARow: Integer; var AEditor: TEditorType);
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
     procedure OnAddRow;
     procedure OnCloneRow;
     procedure SetEdit;
     procedure OpenInfo;
     procedure CloseInfo;
    Public
     property PTreeModule :PTTreeView       read FTreeModule    write FTreeModule;
     property PsgGrid     :PTAdvStringGrid  read FsgGrid        write FsgGrid;
     property PPageIndex  :Integer          read m_nPageIndex   write m_nPageIndex;
     property PIndex      :Integer          read m_nIndex       write m_nIndex;
     property PMasterIndex:Integer          read m_nMasterIndex write m_nMasterIndex;
     property PChild      :CL3VMeterEditor  read FChild         write FChild;
     property PTreeLoader :PCTreeLoader     read FTreeLoader    write FTreeLoader;
     property PGroupIndex  :Integer          read m_nGroupIndex  write m_nGroupIndex;
     property PsgGridChild     :PTAdvStringGrid  read FsgGridChild   write FsgGridChild;
    End;
implementation
constructor CL3GroupEditor.Create;
Begin

End;
//ExtractFilePath(Application.ExeName)
{
     m_sbyID         : Byte;
     m_sbyGroupID    : Byte;
     m_swAmVMeter    : Word;
     m_sGroupName    : String[30];
     m_sGroupExpress : String[100];
}

destructor CL3GroupEditor.Destroy;
begin
  if FChild <> nil then FreeAndNil(FChild);
  if m_nCmdList <> nil then FreeAndNil(m_nCmdList);
  if m_nPlaneList <> nil then FreeAndNil(m_nPlaneList);

  inherited;
end;

procedure CL3GroupEditor.Init;
Var
    i : Integer;
Begin
    m_strCurrentDir := ExtractFilePath(Application.ExeName) + '\\Settings\\';
    m_nCmdList   := TStringList.Create;
    m_nCmdList.LoadFromFile(m_strCurrentDir+'CommandType.dat');
    m_nPlaneList := TStringList.Create;
    m_nRowIndex   := -1;
    m_nRowIndexEx := -1;
    m_nIDIndex    := 3;
    //FTreeModule.Color    := KNS_COLOR;
    FsgGrid.Color       := KNS_NCOLOR;
    FsgGrid.ColCount    := 10;
    FsgGrid.RowCount    := 100;
    FsgGrid.Cells[0,0]  := '�/T';
    FsgGrid.Cells[1,0]  := 'ID';
    FsgGrid.Cells[2,0]  := 'AID';
    FsgGrid.Cells[3,0]  := 'GID';
    FsgGrid.Cells[4,0]  := 'LEV';
    FsgGrid.Cells[5,0]  := '���.';
    FsgGrid.Cells[6,0]  := '��������';
    FsgGrid.Cells[7,0]  := '���������';
    FsgGrid.Cells[8,0]  := '�������� ����';
    FsgGrid.Cells[9,0]  := '����������';
    FsgGrid.ColWidths[0]:= 30;
    FsgGrid.ColWidths[1]:= 0;
    FsgGrid.ColWidths[2]:= 0;
    FsgGrid.ColWidths[3]:= 0;
    FsgGrid.ColWidths[4]:= 35;
    FsgGrid.ColWidths[5]:= 35;
    FsgGrid.ColWidths[6]:= 180;
    FsgGrid.ColWidths[7]:= 200;
    m_nTehnoLen         := 2*35+180+200;
    FChild              := CL3VMeterEditor.Create;
    FChild.PMasterIndex := 0;
    FChild.PPageIndex   := 3;
    InitComboPl;
    //m_strL2SelNode := '�������� �����';
    //ExecSetTree;
    //ExpandTree(FTreeModule^,'������');
    //ExecSetGrid;
End;
procedure CL3GroupEditor.OpenInfo;
Begin
    FsgGrid.ColWidths[0]:= 30;
    FsgGrid.ColWidths[1]:= 0;
    FsgGrid.ColWidths[2]:= 35;
    FsgGrid.ColWidths[3]:= 35;
    FsgGrid.ColWidths[4]:= 35;
    FsgGrid.ColWidths[5]:= 35;
    FsgGrid.ColWidths[6]:= 180;
    FsgGrid.ColWidths[7]:= 200;
    m_nTehnoLen         := 4*35+180+200;
    OnFormResize;
End;
procedure CL3GroupEditor.CloseInfo;
Begin
    FsgGrid.ColWidths[0]:= 30;
    FsgGrid.ColWidths[1]:= 0;
    FsgGrid.ColWidths[2]:= 0;
    FsgGrid.ColWidths[3]:= 0;
    FsgGrid.ColWidths[4]:= 35;
    FsgGrid.ColWidths[5]:= 35;
    FsgGrid.ColWidths[6]:= 180;
    FsgGrid.ColWidths[7]:= 200;
    m_nTehnoLen         := 2*35+180+200;
    OnFormResize;
End;


procedure CL3GroupEditor.OnMDownGE(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
var
m_sTbl : SL3VMETERTAG;
i:integer;
Begin
  //  blOnClickfrom := true;
    if (Button=mbLeft)and(Shift=[ssCtrl,ssLeft]) then
     Begin
     if FsgGrid.Cells[3,m_nRowIndex]='' then exit;
     frmEditExpr.m_forGroup   := StrToInt(FsgGrid.Cells[3,m_nRowIndex]);
     frmEditExpr.m_forVMID    := 0;
     frmEditExpr.m_forAbon    := m_nMasterIndex;
     frmEditExpr.m_forParam   := m_nCmdList.IndexOf(FsgGridChild.Cells[3,1]);//13;//m_nCmdList.IndexOf(FsgGridChild.Cells[3,m_nRowIndex]);
     //frmEditExpr.m_forParam   := 0;
     frmEditExpr.m_forCurrExpr:= FsgGrid.Cells[7,m_nRowIndex];
     if m_pDB.GetVParamsTable(m_nMasterIndex,m_sTbl)=True then
     begin
     frmEditExpr.m_forCurrShExpr := m_sTbl.Item.Items[m_nRowIndex-1].m_sParam;
     frmEditExpr.SetParent(FsgGridChild,@m_sTbl,blOnClickfrom);
     end;
     blOnClickfrom := true;
     frmEditExpr.SetParentGe(FsgGrid,blOnClickfrom);
     frmEditExpr.ShowModal;
     if frmEditExpr.m_forRunExpr='' then FsgGrid.Cells[7,m_nRowIndex]:='Free';
     FsgGrid.Cells[7,m_nRowIndex]:= frmEditExpr.m_forRunExpr;
   End;
End;
procedure CL3GroupEditor.SetEdit;
Var
    pTbl : SL3INITTAG;
    i    : Integer;
Begin
    m_nRowIndex := -1;
    {FreeAllIndex;
    if m_pDB.GetGroupsTable(pTbl)=True then for i:=0 to pTbl.Count-1 do SetIndex(pTbl.Items[i].m_sbyGroupID);
    }
End;
procedure CL3GroupEditor.OnFormResize;
Var
    i : Integer;
Begin
    for i:=8 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-(m_nTehnoLen)-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1-7));
    FChild.OnFormResize;
End;
//Edit Add Del Request
procedure CL3GroupEditor.OnEditNode;
begin
    m_byTrEditMode                  := ND_EDIT;
    ExecSetEditData(m_nIndex);
end;
procedure CL3GroupEditor.OnAddNode;
begin;
    m_byTrEditMode                  := ND_ADD;
    //m_nIndex                        := GenIndex;
end;
procedure CL3GroupEditor.OnDeleteNode;
Begin
    m_byTrEditMode                  := ND_DEL;
    ExecSetEditData(m_nIndex);
    m_strL3SelNode := '������';
End;
//Edit Add Del Execute
procedure CL3GroupEditor.ExecSetEditData(nIndex:Integer);
Var
    m_sTbl : SL3GROUPTAG;
Begin
    TraceL(3,0,'ExecSetEditData.');
    m_sTbl.m_sbyGroupID    := nIndex;
End;
procedure CL3GroupEditor.ExecEditData;
Var
    m_sTbl : SL3GROUPTAG;
Begin
    TraceL(3,0,'ExecEditData.');
End;
procedure CL3GroupEditor.ExecAddData;
Var
    m_sTbl : SL3GROUPTAG;
Begin
    TraceL(3,0,'ExecAddData.');
    //SetIndex(m_nIndex);
End;
procedure CL3GroupEditor.InitComboPl;
Var
    pTable : TM_PLANES;
    i : Integer;
Begin
    if m_pDB.GetTPlanesTable(pTable) then
    Begin
     FsgGrid.Combobox.Items.Clear;
     m_nPlaneList.Clear;
     for i:=0 to pTable.Count-1 do
     Begin
      FsgGrid.Combobox.Items.Add(pTable.Items[i].m_sName);
      m_nPlaneList.Add(pTable.Items[i].m_sName);
     End;
    End;
End;
procedure CL3GroupEditor.ExecDelData;
//Var
//    m_sTbl : SL3GROUPTAG;
//    i,wMID : Integer;
Begin
    TraceL(3,0,'ExecDelData.');
    {
    if m_pDB.GetVMetersTable(m_nIndex,m_sTbl)=True then
     for i:=0 to m_sTbl.m_swAmVMeter-1 do
     Begin
      wMID := m_sTbl.Item.Items[i].m_swVMID;
      m_blVMeterIndex[wMID] := True;
     End;
    }
    m_pDB.DelGroupTable(m_nMasterIndex,m_nIndex);
    SetEdit;
    //FreeIndex(m_nIndex);
End;
procedure CL3GroupEditor.ExecInitLayer;
Begin
    TraceL(3,0,'ExecInitLayer.');
    //mL2Module.Init;
    //SendMSG(BOX_L3,DIR_L2TOL3,DL_STARTSNDR_IND);
End;
//Tree Reload
procedure CL3GroupEditor.ExecSetTree;
Begin
    TraceL(1,0,'ExecSetTree.');
    FTreeLoader.LoadTree;
End;
//Grid Routine
procedure CL3GroupEditor.ExecSetGrid;
Var
    pTbl : SL3INITTAG;
    i : Integer;
Begin
    FsgGrid.ClearNormalCells;
    m_nRowIndex := -1;
    if m_pDB.GetAbonGroupsTable(m_nMasterIndex,pTbl)=True then
    Begin
     m_nAmRecords := pTbl.Count;
     for i:=0 to pTbl.Count-1 do
     Begin
      //SetIndex(pTbl.Items[i].m_sbyGroupID);
      AddRecordToGrid(i,@pTbl.Items[i]);
     End;
     ViewDefault;
     //ViewChild(pTbl.Item.Items[0].m_sbyGroupID);
    End else ViewChild($ffff);
End;
procedure CL3GroupEditor.ViewDefault;
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
procedure CL3GroupEditor.AddRecordToGrid(nIndex:Integer;pTbl:PSL3GROUPTAG);
Var
   nY : Integer;
   nVisible : Integer;
Begin
    nY := nIndex+1;
    nVisible := round(FsgGrid.Height/21);
    //if (nY-nVisible)>0  then FsgGrid.TopRow := nY-nVisible;
    with pTbl^ do Begin
     FsgGrid.Cells[0,nY] := IntToStr(nY);
     FsgGrid.Cells[1,nY] := IntToStr(pTbl.m_sbyID);
     FsgGrid.Cells[2,nY] := IntToStr(pTbl.m_swABOID);
     FsgGrid.Cells[3,nY] := IntToStr(pTbl.m_sbyGroupID);
     FsgGrid.Cells[4,nY] := IntToStr(pTbl.M_NGROUPLV);
     FsgGrid.Cells[5,nY] := IntToStr(pTbl.m_swPosition);

     FsgGrid.Cells[6,nY] := pTbl.m_sGroupName;
     FsgGrid.Cells[7,nY] := pTbl.m_sGroupExpress;
     if (m_nPlaneList.Count=0)or(m_swPLID<0)or(m_swPLID>=m_nPlaneList.Count) then FsgGrid.Cells[8,nY]:='����' else
     FsgGrid.Cells[8,nY] := m_nPlaneList.Strings[m_swPLID];
     FsgGrid.Cells[9,nY] := m_nEsNoList.Strings[pTbl.m_sbyEnable];
    End;
End;
procedure CL3GroupEditor.OnSetGrid;
Begin
    ExecSetGrid;
End;
procedure CL3GroupEditor.OnSaveGrid;
Var
    i : Integer;
    pTbl:SL3GROUPTAG;
Begin
    for i:=1 to FsgGrid.RowCount-1 do
    Begin
     if FsgGrid.Cells[m_nIDIndex,i]='' then break;
     pTbl.m_sbyID := i;
     GetGridRecord(pTbl);
     m_pDB.addGroupId(pTbl);
    End;
    ExecSetGrid;
End;
procedure CL3GroupEditor.GetGridRecord(var pTbl:SL3GROUPTAG);
Var
    i : Integer;
    str : String;
Begin
    i := pTbl.m_sbyID;
    with pTbl do Begin
     pTbl.m_sbyID         := StrToInt(FsgGrid.Cells[1,i]);
     pTbl.m_swABOID       := StrToInt(FsgGrid.Cells[2,i]);
     pTbl.m_sbyGroupID    := StrToInt(FsgGrid.Cells[3,i]);
     pTbl.M_NGROUPLV      := StrToInt(FsgGrid.Cells[4,i]);
     pTbl.m_swPosition    := StrToInt(FsgGrid.Cells[5,i]);
     pTbl.m_sGroupName    := FsgGrid.Cells[6,i];
     pTbl.m_sGroupExpress := FsgGrid.Cells[7,i];
     pTbl.m_swPLID        := m_nPlaneList.IndexOf(FsgGrid.Cells[8,i]);
     pTbl.m_sbyEnable     := m_nEsNoList.IndexOf(FsgGrid.Cells[9,i]);
    End;
End;
procedure CL3GroupEditor.SetDefaultRow(i:Integer);
Begin
    if FsgGrid.Cells[1,i]=''  then FsgGrid.Cells[1,i]  := '0';
    if FsgGrid.Cells[2,i]=''  then FsgGrid.Cells[2,i]  := IntToStr(m_nMasterIndex);
    //if FsgGrid.Cells[3,i]=''  then FsgGrid.Cells[3,i]  := IntToStr(GenIndex);
    if FsgGrid.Cells[3,i]=''  then FsgGrid.Cells[3,i]  := '-1';
    if FsgGrid.Cells[4,i]=''  then FsgGrid.Cells[4,i]  := '0';
    if FsgGrid.Cells[5,i]=''  then FsgGrid.Cells[5,i]  := '0';
    if FsgGrid.Cells[6,i]=''  then FsgGrid.Cells[6,i]  := 'Group '+FsgGrid.Cells[m_nIDIndex,i];
    if FsgGrid.Cells[7,i]=''  then FsgGrid.Cells[7,i]  := '[x]';
    if FsgGrid.Cells[8,i]=''  then Begin if m_nPlaneList.Count<>0 then FsgGrid.Cells[8,i] := m_nPlaneList.Strings[0] else FsgGrid.Cells[8,i] :='����� �� ���������'; End;
    if FsgGrid.Cells[9,i]=''  then FsgGrid.Cells[9,i]  := m_nEsNoList.Strings[1];
End;
procedure CL3GroupEditor.ExecSelRowGrid;
Begin
    FsgGrid.SelectRows(FindRow(IntToStr(m_nIndex)),1);
    FsgGrid.Refresh;
    ViewChild(m_nIndex);
End;
function CL3GroupEditor.FindRow(str:String):Integer;
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
procedure CL3GroupEditor.ViewChild(nIndex:Integer);
Begin
    if m_blCL3GroupEditor=False then  
    if FChild<>Nil then
    Begin
     FChild.PMasterIndex := nIndex;
     FChild.PAbonIndex   := m_nMasterIndex;
     FChild.ExecSetGrid;
    End;
End;
function CL3GroupEditor.FindFreeRow(nIndex:Integer):Integer;
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
procedure CL3GroupEditor.OnAddRow;
Var
    nIndex : Integer;
Begin
    if m_nRowIndex<>-1 then
    Begin
     SetDefaultRow(m_nRowIndex);
     //SetIndex(StrToInt(FsgGrid.Cells[m_nIDIndex,m_nRowIndex]));
    End else
    Begin
     nIndex := FindFreeRow(3);
     SetDefaultRow(nIndex);
     //SetIndex(StrToInt(FsgGrid.Cells[m_nIDIndex,nIndex]));
    End;
End;
procedure CL3GroupEditor.OnCloneRow;
Var
    nIndex : Integer;
    pTbl   : SL3GROUPTAG;
Begin
    if m_nRowIndex<>-1 then
    if m_nRowIndex<=FindFreeRow(m_nIDIndex)-1 then
    Begin
     pTbl.m_sbyID   := m_nRowIndex;
     GetGridRecord(pTbl);
     //pTbl.m_sbyGroupID := GenIndexSv;
     pTbl.m_sbyGroupID := -1;
     AddRecordToGrid(FindFreeRow(m_nIDIndex)-1,@pTbl);
    End;
End;
procedure CL3GroupEditor.OnDelRow;
Var
    nFind : Integer;
Begin
    if m_nAmRecords=FindFreeRow(m_nIDIndex)-1 then
    Begin
     if m_nIndex<>-1 then
     Begin
      m_pDB.DelGroupTable(m_nMasterIndex,m_nIndex);
      SetEdit;
      ExecSetGrid;
      ViewChild(m_nIndex);
     End;
    End else
    Begin
     if m_nRowIndex<>-1 then
     Begin
      //if FsgGrid.Cells[m_nIDIndex,m_nRowIndex]<>'' then
      //FreeIndex(StrToInt(FsgGrid.Cells[m_nIDIndex,m_nRowIndex]));
      FsgGrid.ClearRows(m_nRowIndex,1);
     End;
    End;
End;
procedure CL3GroupEditor.OnDelAllRow;
Var
    i,wMID : Integer;
    pTbl   : SL3GROUPTAG;
Begin
    m_pDB.DelGroupTable(m_nMasterIndex,-1);
    SetEdit;
    ExecSetGrid;
    {
     if m_pDB.GetVMetersTable(-1,pTbl)=True then
     for i:=0 to pTbl.m_swAmVMeter-1 do
     Begin
      wMID := pTbl.Item.Items[i].m_swVMID;
      //mL1Module.DelNodeLv(wMID);
      m_blVMeterIndex[wMID] := True;
     End;
    m_pDB.DelGroupTable(-1);
    FreeAllIndex;
    ExecSetGrid;
    }
End;
procedure CL3GroupEditor.OnClickGrid(Sender: TObject; ARow, ACol: Integer);
Begin
    m_nRowIndex    := -1;
    m_nRowIndexEx  := -1;
    if ARow>0 then Begin
     m_nRowIndex   := ARow;
     m_nRowIndexEx := ARow;
     if FsgGrid.Cells[m_nIDIndex,ARow]<>'' then
     Begin
      m_nIndex := StrToInt(FsgGrid.Cells[m_nIDIndex,ARow]);
      ViewChild(m_nIndex);
     End else m_nIndex := -1;
    End;
End;
//Init Layer
procedure CL3GroupEditor.OnInitLayer;
Begin
    //ExecSetTree;
    //ExecInitLayer;
End;

procedure CL3GroupEditor.OnExecute(Sender: TObject);
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
procedure CL3GroupEditor.OnChannelGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
     OnGlGetCellColor(Sender,ARow,ACol,AState,ABrush,AFont);
end;
procedure CL3GroupEditor.OnChannelGetCellType(Sender: TObject; ACol, ARow: Integer;var AEditor: TEditorType);
begin
    with FsgGrid^ do
    case ACol of
     8:Begin
        AEditor := edComboList;
        InitComboPl;
       End;
     9:Begin
        AEditor := edComboList;
        combobox.items.loadfromfile(m_strCurrentDir+'Active.dat');
       End;
    end;
end;
function CL3GroupEditor.GetComboIndex(cbCombo:TComboBox;str:String):Integer;
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
procedure CL3GroupEditor.SendMSG(byBox,byFor,byType:Byte);
Var
    pMsg : CHMessage;
Begin
    With pMsg do
    Begin
    m_swLen       := 13;
    m_swObjID     := m_nIndex;
    m_sbyFrom     := byFor;
    m_sbyFor      := byFor;
    m_sbyType     := byType;
    m_sbyTypeIntID:= 0;
    m_sbyIntID    := m_nMasterIndex;
    m_sbyServerID := 0;
    m_sbyDirID    := 0;
    end;
    FPUT(byBox,@pMsg);
End;
end.
