unit knsl3cheditor;
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,Messages,
  Graphics, Controls, Forms, Dialogs, Spin,
  Grids, BaseGrid, AdvGrid,utlbox,utlconst,utldatabase,knsl1module,knsl2module,
  knsl3chdteditor,knsl2treeloader,knsl5tracer,knsl5config, knsl2BTIInit;
type
    CL3ChEditor = class
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
     FChild         : CL3ChdtEditor;
     FTreeLoader    : PCTreeLoader;
     m_sKI,m_sKU    : Double;
     m_sddFabNum    : String;
     m_sddPHAddres  : String;
     m_nPR          : Integer;
     FTRI           : PCTreeIndex;
     pTbl           : SL3CHANDGES;
     constructor Create;
     function  FindRow(str:String):Integer;
     procedure ViewChild(nIndex:Integer);
     procedure OnExecute(Sender: TObject);
     procedure ExecEditData;
     procedure ExecAddData;
     procedure ExecDelData;

     procedure AddRecordToGrid(nIndex:Integer;pTbl:PSL3CHANDGE);
     function  SetIndex(nIndex : Integer):Integer;
     function  GenIndex:Integer;
     function  GenIndexSv:Integer;
     procedure FreeAllIndex;
     procedure FreeIndex(nIndex : Integer);
     function  FindFreeRow(nIndex:Integer):Integer;
     procedure GetGridRecord(var pTbl:SL3CHANDGE);
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
     procedure OnEditNode;
     procedure OnAddNode;
     procedure OnDeleteNode;
     procedure OnSaveGrid;
     procedure OnSetGrid;
     procedure OnSetDataGrid(nCmdID,nType:Integer);
     procedure OnInitLayer;
     procedure OnDelRow;
     procedure OnDelAllRow;
     procedure OnAddRow;
     procedure OnCloneRow;
     procedure SetEdit;
     procedure OnActivateDesc(blType:Boolean);
     function  OnSaveNewL2Param:Boolean;
    Public
     property PTRI        :PCTreeIndex      read FTRI         write FTRI;
     property PTreeModule :PTTreeView       read FTreeModule  write FTreeModule;
     property PsgGrid     :PTAdvStringGrid  read FsgGrid      write FsgGrid;
     property PsgCGrid    :PTAdvStringGrid  read FsgCGrid     write FsgCGrid;
     property PPageIndex  :Integer          read m_nPageIndex write m_nPageIndex;
     property PIndex      :Integer          read m_nIndex     write m_nIndex;
     property PMIndex     :Integer          read m_nMIndex    write m_nMIndex;
     property PChild      :CL3ChdtEditor    read FChild       write FChild;
     property PTreeLoader :PCTreeLoader     read FTreeLoader  write FTreeLoader;
    End;
implementation
constructor CL3ChEditor.Create;
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
procedure CL3ChEditor.Init;
Var
    i : Integer;
Begin
    m_strCurrentDir := ExtractFilePath(Application.ExeName) + '\\Settings\\';
    for i:=0 to MAX_CHNG  do m_blChngIndex[i]  := True;
    m_nRowIndex  := -1;
    m_nPageIndex := 0;
    m_nIDIndex   := 2;
    m_nIndex     := 0;
    m_nType      := 0;
    //FsgGrid.Color       := KNS_NCOLOR;
    FsgGrid.ColCount    := 14;
    FsgGrid.RowCount    := 40;
    FsgGrid.Cells[0,0]  := '№/T';
    FsgGrid.Cells[1,0]  := 'VMID';
    FsgGrid.Cells[2,0]  := 'CHID';
    FsgGrid.Cells[3,0]  := 'Время';
    FsgGrid.Cells[4,0]  := 'Комментарий';
    FsgGrid.Cells[5,0]  := 'Зав.№';
    FsgGrid.Cells[6,0]  := 'Адр.';
    FsgGrid.Cells[7,0]  := 'KU';
    FsgGrid.Cells[8,0]  := 'KI';
    FsgGrid.Cells[9,0]  := 'Зав.№"';
    FsgGrid.Cells[10,0] := 'Адр."';
    FsgGrid.Cells[11,0] := 'KU"';
    FsgGrid.Cells[12,0] := 'KI"';
    FsgGrid.Cells[13,0] := 'Активн.';
    FsgGrid.ColWidths[0]:= 30;
    FsgGrid.ColWidths[1]:= 30;
    FsgGrid.ColWidths[2]:= 30;
    FsgGrid.ColWidths[3]:= 50;
    FsgGrid.ColWidths[4]:= 150;
    //ExecSetGrid;
    //FChild                := CL2Editor.Create;
    //FChild.PPageIndex     := 1;
End;

procedure CL3ChEditor.OnFormResize;
Var
    i : Integer;
Begin
    for i:=5 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-(30+30+50+150)-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1-4));
    //for i:=4 to FsgCGrid.ColCount-1  do FsgCGrid.ColWidths[i]  := trunc((FsgCGrid.Width-(190+70+50)-2*FsgCGrid.ColWidths[0])/(FsgCGrid.ColCount-1-3));
    PChild.OnFormResize;
End;
procedure CL3ChEditor.SetEdit;
Var
    pTbl : SL3CHANDGES;
    i    : Integer;
Begin
    m_nRowIndex  := -1;
    FreeAllIndex;
    if m_pDB.GetChandgeTable(PMIndex,False,pTbl)=True then for i:=0 to pTbl.Count-1 do SetIndex(pTbl.Items[i].m_swCHID);
End;
//Edit Add Del Request
procedure CL3ChEditor.OnEditNode;
begin
end;
procedure CL3ChEditor.OnAddNode;
begin
end;
procedure CL3ChEditor.OnDeleteNode;
Begin
End;
//Edit Add Del Execute
procedure CL3ChEditor.ExecSetEditData(nIndex:Integer);
Begin
End;
procedure CL3ChEditor.ExecEditData;
Begin
End;
procedure CL3ChEditor.ExecAddData;
Begin
End;
procedure CL3ChEditor.ExecDelData;
Begin
End;
procedure CL3ChEditor.ExecInitLayer;
Begin
    TraceL(1,0,'ExecInitLayer.');
    mL1Module.Init;
End;
//Tree Reload
procedure CL3ChEditor.ExecSetTree;
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
procedure CL3ChEditor.OnActivateDesc(blType:Boolean);
Var
    i : Integer;
Begin
    if (m_nRowIndex<>-1)and(m_nRowIndex<=pTbl.Count) then
    for i:=0 to pTbl.Count-1 do
    Begin
     pTbl.Items[i].m_sbyEnable := 0;
     if (i=(m_nRowIndex-1))and(blType=True) then pTbl.Items[i].m_sbyEnable := 1;
     m_pDB.SetChandgeTable(pTbl.Items[i]);
    End;
    ExecSetGrid;
    ViewChild(PIndex);
End;
function CL3ChEditor.OnSaveNewL2Param:Boolean;
Var
    sddFabNum,sddPHAddres:String;
    sfKI,sfKU:Double;
Begin
    try
    Result := False;
    if m_nRowIndex<>-1 then
    Begin
     if (FsgGrid.Cells[5,m_nRowIndex]<>'')and(FsgGrid.Cells[6,m_nRowIndex]<>'')and(FsgGrid.Cells[7,m_nRowIndex]<>'')and(FsgGrid.Cells[8,m_nRowIndex]<>'') then
     Begin
      sddFabNum   := FsgGrid.Cells[9,m_nRowIndex];
      sddPHAddres := FsgGrid.Cells[10,m_nRowIndex];
      sfKI      := StrToFloat(FsgGrid.Cells[11,m_nRowIndex]);
      sfKU      := StrToFloat(FsgGrid.Cells[12,m_nRowIndex]);
      if MessageDlg('Параметры верны? Зав.№:'+sddFabNum+' '+'Адр.:'+sddPHAddres+' '+'KI:'+FloatToStr(sfKI)+' '+'KU:'+FloatToStr(sfKU),mtWarning,[mbOk,mbCancel],0)=mrOk then
      Begin
       m_pDB.SetL2TAG_FN_AD_KI_KU(FTRI.PMID,sddFabNum,sddPHAddres,sfKI,sfKU);
       mL2Module.InitMeter(FTRI.PMID);
       Result := True;
      End;
     End else MessageDlg('Введены не все параметры!',mtWarning,[mbOk,mbCancel],0);
    End else MessageDlg('Выберите дескриптор!',mtWarning,[mbOk,mbCancel],0);
    except

    end;
End;
procedure CL3ChEditor.ExecSetGrid;
Var
    //pTbl : SL3CHANDGES;
    i : Integer;
Begin
    FsgGrid.ClearNormalCells;
    m_pDB.GetKIKU(FTRI.PVID,m_nPR,m_sKI,m_sKU,m_sddFabNum,m_sddPHAddres);
    PChild.KI := m_sKI;
    PChild.KU := m_sKU;
    PChild.PR := m_nPR;
    if m_pDB.GetChandgeTable(PMIndex,False,pTbl)=True then
    Begin
     m_nAmRecords := pTbl.Count;
     FsgGrid.RowCount := pTbl.Count + 20;
     for i:=0 to pTbl.Count-1 do
     Begin
      SetIndex(pTbl.Items[i].m_swCHID);
      AddRecordToGrid(i,@pTbl.Items[i]);
     End;
     ViewChild(StrToInt(FsgGrid.Cells[m_nIDIndex,1]));
     //ViewChild(PIndex);
    End else PChild.PsgGrid.ClearNormalCells;
End;
{
SL3CHANDGE = packed record
     m_swID      : Integer;
     m_swVMID    : Integer;
     m_swCHID    : Integer;
     m_dtTime    : TDateTime;
     m_sComment  : String[100];
     m_sfKU_0    : Double;
     m_sfKI_0    : Double;
     m_sfKU_1    : Double;
     m_sfKI_1    : Double;
     m_sbyEnable : Byte;
     Item        : SL3CHANDTS;
    End;
}

procedure CL3ChEditor.AddRecordToGrid(nIndex:Integer;pTbl:PSL3CHANDGE);
Var
   nY : Integer;
   nVisible : Integer;
Begin
    nY := nIndex+1;
    nVisible := round(FsgGrid.Height/21);
    if (nY-nVisible)>0  then FsgGrid.TopRow := nY-nVisible;
    with pTbl^ do Begin
     FsgGrid.Cells[0,nY]  := IntToStr(nY);
     FsgGrid.Cells[1,nY]  := IntToStr(m_swVMID);
     FsgGrid.Cells[2,nY]  := IntToStr(m_swCHID);
     FsgGrid.Cells[3,nY]  := DateTimeToStr(m_dtTime);
     FsgGrid.Cells[4,nY]  := m_sComment;
     FsgGrid.Cells[5,nY]  := m_sddFabNum_0;
     FsgGrid.Cells[6,nY]  := m_sddPHAddres_0;
     FsgGrid.Cells[7,nY]  := FloatToStr(m_sfKU_0);
     FsgGrid.Cells[8,nY]  := FloatToStr(m_sfKI_0);
     FsgGrid.Cells[9,nY]  := m_sddFabNum_1;
     FsgGrid.Cells[10,nY] := m_sddPHAddres_1;
     FsgGrid.Cells[11,nY] := FloatToStr(m_sfKU_1);
     FsgGrid.Cells[12,nY] := FloatToStr(m_sfKI_1);
     FsgGrid.Cells[13,nY] := m_nActiveList.Strings[m_sbyEnable];
    End;
End;
procedure CL3ChEditor.OnSetGrid;
Begin
    ExecSetGrid;
End;
procedure CL3ChEditor.OnSaveGrid;
Var
    i    : Integer;
    pTbl : SL3CHANDGE;
Begin
    for i:=1 to FsgGrid.RowCount do
    Begin
     if FsgGrid.Cells[1,i]='' then break;
     pTbl.m_swID := i;
     GetGridRecord(pTbl);
     if m_pDB.AddChandgeTable(PIndex,pTbl)=True then SetIndex(pTbl.m_swCHID);
    End;
    ExecSetGrid;
End;
procedure CL3ChEditor.GetGridRecord(var pTbl:SL3CHANDGE);
Var
    i : Integer;
Begin
    i := pTbl.m_swID;
    with pTbl do Begin
     m_swVMID        := StrToInt(FsgGrid.Cells[1,i]);
     m_swCHID        := StrToInt(FsgGrid.Cells[2,i]);
     m_dtTime        := StrToDateTime(FsgGrid.Cells[3,i]);
     m_sComment      := FsgGrid.Cells[4,i];
     m_sddFabNum_0   := FsgGrid.Cells[5,i];
     m_sddPHAddres_0 := FsgGrid.Cells[6,i];
     m_sfKU_0        := StrToFloat(FsgGrid.Cells[7,i]);
     m_sfKI_0        := StrToFloat(FsgGrid.Cells[8,i]);
     m_sddFabNum_1   := FsgGrid.Cells[9,i];
     m_sddPHAddres_1 := FsgGrid.Cells[10,i];
     m_sfKU_1        := StrToFloat(FsgGrid.Cells[11,i]);
     m_sfKI_1        := StrToFloat(FsgGrid.Cells[12,i]);
     m_sbyEnable     := m_nActiveList.IndexOf(FsgGrid.Cells[13,i]);
    End;
End;
procedure CL3ChEditor.SetDefaultRow(i:Integer);
Var
    nIndex : Integer;
Begin
    if FsgGrid.Cells[1,i]=''  then FsgGrid.Cells[1,i]  := IntToStr(PMIndex);
    if FsgGrid.Cells[2,i]=''  then FsgGrid.Cells[2,i]  := IntToStr(GenIndex);
    if FsgGrid.Cells[3,i]=''  then FsgGrid.Cells[3,i]  := DateTimeToStr(Now);
    if FsgGrid.Cells[4,i]=''  then FsgGrid.Cells[4,i]  := 'Неисправность...';
    if FsgGrid.Cells[5,i]=''  then FsgGrid.Cells[5,i]  := m_sddFabNum;
    if FsgGrid.Cells[6,i]=''  then FsgGrid.Cells[6,i]  := m_sddPHAddres;
    if FsgGrid.Cells[7,i]=''  then FsgGrid.Cells[7,i]  := FloatToStr(m_sKI);
    if FsgGrid.Cells[8,i]=''  then FsgGrid.Cells[8,i]  := FloatToStr(m_sKU);
    if FsgGrid.Cells[9,i]=''  then FsgGrid.Cells[9,i]  := 'Заменен...';
    if FsgGrid.Cells[10,i]='' then FsgGrid.Cells[10,i] := m_sddPHAddres;
    if FsgGrid.Cells[11,i]='' then FsgGrid.Cells[11,i] := FloatToStr(m_sKI);
    if FsgGrid.Cells[12,i]='' then FsgGrid.Cells[12,i] := FloatToStr(m_sKU);
    if FsgGrid.Cells[13,i]='' then FsgGrid.Cells[13,i] := m_nActiveList.Strings[0];
    m_nIndex := StrToInt(FsgGrid.Cells[2,i]);
End;
procedure CL3ChEditor.ExecSelRowGrid;
Var
   nRow : Integer;
Begin
    nRow := FindRow(IntToStr(PIndex));
    FsgGrid.SelectRows(nRow,1);
    FsgGrid.Refresh;
    OnClickGrid(self,nRow,0);
    //ViewChild(PIndex);
End;
function CL3ChEditor.FindRow(str:String):Integer;
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
procedure CL3ChEditor.OnSetDataGrid(nCmdID,nType:Integer);
Begin
    m_nType := nType;
    m_pDB.AddChandgeDTTable(PMIndex,PIndex,nCmdID,m_nType);
End;
procedure CL3ChEditor.ViewChild(nIndex:Integer);
Begin
    if m_blCL3ChngEditor=False then
    if FChild<>Nil then
    Begin
     FChild.PMIndex := nIndex;
     FChild.ExecSetGrid;
    End;
End;
function CL3ChEditor.FindFreeRow(nIndex:Integer):Integer;
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
procedure CL3ChEditor.OnAddRow;
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
procedure CL3ChEditor.OnCloneRow;
Var
    nIndex : Integer;
    pTbl   : SL3CHANDGE;
Begin
    if m_nRowIndex<>-1 then
    if m_nRowIndex<=FindFreeRow(3)-1 then
    Begin
     pTbl.m_swID   := m_nRowIndex;
     GetGridRecord(pTbl);
     pTbl.m_swCHID := GenIndexSv;
     AddRecordToGrid(FindFreeRow(3)-1,@pTbl);
    End;
End;
procedure CL3ChEditor.OnDelRow;
Var
    nFind : Integer;
Begin
    if m_nAmRecords=FindFreeRow(3)-1 then
    Begin
     if m_nIndex<>-1 then
     Begin
      //ExecDelData;
      //FreeAllIndex;
      m_pDB.DelChandgeTable(PMIndex,m_nIndex);
      SetEdit;
      ExecSetGrid;
      ViewChild(PIndex);
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
procedure CL3ChEditor.OnDelAllRow;
//Var
//    i : Integer;
Begin
    m_pDB.DelChandgeTable(PMIndex,-1);
    SetEdit;
    ExecSetGrid;
    if FChild<>Nil then
    Begin
     //FChild.PMIndex := m_nIndex;
     FChild.PsgGrid.ClearNormalCells ;
    End;
End;
procedure CL3ChEditor.OnClickGrid(Sender: TObject; ARow, ACol: Integer);
Begin
    m_nRowIndex := -1;
    if ARow>0 then Begin
     if FsgGrid.Cells[m_nIDIndex,ARow]<>'' then
     Begin
      m_nIndex := StrToInt(FsgGrid.Cells[m_nIDIndex,ARow]);
      ViewChild(m_nIndex);
     End else m_nIndex := -1;
     m_nRowIndex := ARow;
    End;
End;
//Init Layer
procedure CL3ChEditor.OnInitLayer;
Begin
    ExecSetTree;
    ExecInitLayer;
End;
//Index Generator
function  CL3ChEditor.GenIndex:Integer;
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
function CL3ChEditor.GenIndexSv:Integer;
Begin
    Result := SetIndex(GenIndex);
End;
function CL3ChEditor.SetIndex(nIndex : Integer):Integer;
Begin
    nIndex := nIndex and $ff;
    m_blChngIndex[nIndex] := False;
    Result := PMindex*256+nIndex;
End;
Procedure CL3ChEditor.FreeIndex(nIndex : Integer);
Begin
    m_blChngIndex[nIndex] := True;
End;
Procedure CL3ChEditor.FreeAllIndex;
Var
    i : Integer;
Begin
    for i:=0 to MAX_CHNG do
    m_blChngIndex[i] := True;
End;
procedure CL3ChEditor.OnExecute(Sender: TObject);
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
procedure CL3ChEditor.OnChannelGetCellColor(Sender: TObject; ARow,
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
            1,2,3,4,9,
            10,11,12   : if (ARow and 1)<>0 then ABrush.Color := $00E5D7D0 else ABrush.Color := clWhite;
            5,6,7,8,13 : if (ARow and 1)= 0 then ABrush.Color := $00E5D7D0 else ABrush.Color := clWhite;
       End;
      End;
     End;
    End;
    End;
end;
procedure CL3ChEditor.OnGetType(Sender: TObject; ACol, ARow: Integer;var AEditor: TEditorType);
begin
    with FsgGrid^ do
    case ACol of
     13:Begin
        AEditor := edComboList;
        combobox.items.loadfromfile(m_strCurrentDir+'Active.dat');
       End;
    end;
end;
end.
 