unit knsl3tariffeditor;
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,Messages,
  Graphics, Controls, Forms, Dialogs, Spin,
  Grids, BaseGrid, AdvGrid,utlbox,utlconst,utldatabase,knsl1module,
  knsl2treeloader,knsl5tracer,knsl5config,knsl3EventBox;
type
    CL3TariffEditor = class
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
     FChild         : CL3TariffEditor;
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

     procedure AddRecordToGrid(nIndex:Integer;pTbl:PTM_TARIFF);
     function  SetIndex(nIndex : Integer):Integer;
     function  GenIndex:Integer;
     function  GenIndexSv:Integer;
     procedure FreeIndex(nIndex : Integer);
     Procedure FreeAllIndex;
     procedure GetGridRecord(var pTbl:TM_TARIFF);
     function  GetComboIndex(cbCombo:TComboBox;str:String):Integer;
     procedure SetDefaultRow(i:Integer);
    Public
     procedure Init;
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
     procedure OnSaveNewIndex(nOldIndex,nNewIndex:Integer);
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
     property PChild      : CL3TariffEditor  read FChild         write FChild;
     property PTreeLoader :PCTreeLoader     read FTreeLoader    write FTreeLoader;
    End;
implementation
constructor CL3TariffEditor.Create;
Begin

End;
{
TM_TARIFF = packed record
     m_swID       : Word;
     m_swTID      : Word;
     m_swTTID     : Word;
     m_sName      : String[100];
     m_dtTime0    : TDateTime;
     m_dtTime1    : TDateTime;
     m_sbyEnable  : Byte;
    End;
    TM_TARIFFS = packed record
     m_swID       : Word;
     m_swTTID     : Word;
     m_sName      : String[100];
     m_swCMDID    : Word;
     m_dtTime0    : TDateTime;
     m_dtTime1    : TDateTime;
     m_sbyEnabled : Boolean;
     Count     : Word;
     Items     : array of TM_TARIFF;
    End;
    PTM_TARIFFS =^ TM_TARIFFS;
    TM_TARIFFSS = packed record
     Count     : Word;
     Items     : array of TM_TARIFFS;
    End;
}
procedure CL3TariffEditor.Init;
Var
    i : Integer;
Begin
    m_strCurrentDir := ExtractFilePath(Application.ExeName) + '\\Settings\\';
    //for i:=0 to MAX_MTYPE do m_blMTypeIndex[i] := True;
    m_nRowIndex         := -1;
    m_nRowIndexEx       := 2;
    m_nIDIndex          := 4;
    FsgGrid.Color       := KNS_NCOLOR;
    FsgGrid.ColCount    := 10;
    FsgGrid.RowCount    := 60;
    FsgGrid.Cells[0,0]  := '№/T';
    FsgGrid.Cells[1,0]  := 'ID';
    FsgGrid.Cells[2,0]  := 'ТID';
    FsgGrid.Cells[3,0]  := 'ТТип';
    FsgGrid.Cells[4,0]  := 'Тип';
    FsgGrid.Cells[5,0]  := 'Название';
    FsgGrid.Cells[6,0]  := 'Комментарий';
    FsgGrid.Cells[7,0]  := 'Начало периода';
    FsgGrid.Cells[8,0]  := 'Окончание периода';
    FsgGrid.Cells[9,0]  := 'Тарифный коэффициент';
    FsgGrid.Cells[10,0]  := 'Активность';

    FsgGrid.ColWidths[0]:= 35;
    FsgGrid.ColWidths[1]:= 0;
    FsgGrid.ColWidths[2]:= 0;
    FsgGrid.ColWidths[3]:= 0;
    FsgGrid.ColWidths[4]:= 0;
    FsgGrid.ColWidths[5]:= 0;
    FsgGrid.ColWidths[6]:= 300;
    m_nTehnoLen         := 4*0+100+300;
    //SetHigthGrid(FsgGrid^,20);
    //ExecSetTree;
    //ExpandTree(FTreeModule^,'Каналы');
    ExecSetGrid;
    {
    FChild             := CL3TariffEditor.Create;
    FChild.PTreeModule := FTreeModule;
    FChild.PsgGrid     := FsgCGrid;
    if FsgGrid.Cells[2,1]<>'' then
    FChild.PMasterIndex:= StrToInt(FsgGrid.Cells[2,1]);
    FChild.Init;
    }
End;
procedure CL3TariffEditor.OpenInfo;
Begin
    FsgGrid.ColWidths[0]:= 35;
    FsgGrid.ColWidths[1]:= 35;
    FsgGrid.ColWidths[2]:= 35;
    FsgGrid.ColWidths[3]:= 35;
    FsgGrid.ColWidths[4]:= 35;
    FsgGrid.ColWidths[5]:= 100;
    FsgGrid.ColWidths[6]:= 300;
    m_nTehnoLen         := 4*35+100+300;
    OnFormResize;
End;
procedure CL3TariffEditor.CloseInfo;
Begin
    FsgGrid.ColWidths[0]:= 35;
    FsgGrid.ColWidths[1]:= 0;
    FsgGrid.ColWidths[2]:= 0;
    FsgGrid.ColWidths[3]:= 0;
    FsgGrid.ColWidths[4]:= 0;
    FsgGrid.ColWidths[5]:= 0;
    FsgGrid.ColWidths[6]:= 300;
    m_nTehnoLen         := 4*0+0+300;
    OnFormResize;
End;
procedure CL3TariffEditor.SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
Var
    i : Integer;
Begin
   // for i:=0 to sgGrid.RowCount-1 do Begin sgGrid.Cells[0,i+1] := IntToStr(i+1); sgGrid.RowHeights[i]:= nHigth;End;
End;
procedure CL3TariffEditor.OnFormResize;
Var
    i : Integer;
Begin
    for i:=7 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-(m_nTehnoLen)-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1-6));
    //FChild.OnFormResize;
End;
procedure CL3TariffEditor.SetEdit;
begin
    m_nRowIndex         := -1;
end;
//Edit Add Del Request
procedure CL3TariffEditor.OnEditNode;
begin
end;
procedure CL3TariffEditor.OnAddNode;
begin
end;
procedure CL3TariffEditor.OnDeleteNode;
Begin
End;
//Edit Add Del Execute
procedure CL3TariffEditor.ExecSetEditData(nIndex:Integer);
Begin
    TraceL(1,0,'ExecSetEditData.');
End;
procedure CL3TariffEditor.ExecEditData;
Begin
    TraceL(1,0,'ExecEditData.');
End;
procedure CL3TariffEditor.ExecAddData;
Begin
    TraceL(1,0,'ExecAddData.');
End;
procedure CL3TariffEditor.ExecDelData;
Begin
    TraceL(1,0,'ExecDelData.');
End;
procedure CL3TariffEditor.ExecInitLayer;
Begin
    TraceL(1,0,'ExecInitLayer.');
End;
//Tree Reload
procedure CL3TariffEditor.ExecSetTree;
Begin
    TraceL(1,0,'ExecSetTree.');
End;
//Grid Routine
procedure CL3TariffEditor.ExecSelRowGrid;
Begin
    FsgGrid.SelectRows(FindRow(IntToStr(m_nIndex)),1);
    FsgGrid.Refresh;
    ViewChild(m_nIndex);
End;
function CL3TariffEditor.FindRow(str:String):Integer;
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
procedure CL3TariffEditor.ViewChild(nIndex:Integer);
Begin
    if FChild<>Nil then
    Begin
     FChild.PMasterIndex := nIndex;
     FChild.ExecSetGrid;
    End;
End;
procedure CL3TariffEditor.ExecSetGrid;
Var
    pTbl : TM_TARIFFS;
    i : Integer;
Begin
    FsgGrid.ClearNormalCells;
    if m_pDB.GetTMTarPeriodsTable(-1,m_nMasterIndex,pTbl)=True then
    Begin
     m_nAmRecords := pTbl.Count;
     for i:=0 to pTbl.Count-1 do
     Begin
      //SetIndex(pTbl.Items[i].m_swType);
      AddRecordToGrid(i,@pTbl.Items[i]);
     End;
     ViewDefault;
    End;
End;
procedure CL3TariffEditor.ViewDefault;
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
procedure CL3TariffEditor.OnSaveNewIndex(nOldIndex,nNewIndex:Integer);
Var
    pOldTbl : TM_TARIFFS;
    pNewTbl : TM_TARIFFS;
    i : Integer;
Begin
    //if nNewIndex=131072 then
    // pNewTbl.Count := 0;
    m_pDB.GetTMTarPeriodsTable(-1,nNewIndex,pNewTbl);
    if m_pDB.GetTMTarPeriodsTable(-1,nOldIndex,pOldTbl)=True then
    Begin
     for i:=0 to pOldTbl.Count-1 do
     Begin
      pOldTbl.Items[i].m_swZoneID := nNewIndex;
      if pNewTbl.Count<>0  then
      if i<=pNewTbl.Count-1 then
      Begin
       pOldTbl.Items[i].m_swID := pNewTbl.Items[i].m_swID;
       //if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'i:'+IntToStr(i)+' nOldIndex:'+IntToStr(nOldIndex)+' nNewIndex:'+IntToStr(nNewIndex)+' OldID:'+IntToStr(pOldTbl.Items[i].m_swID)+' NewID:'+IntToStr(pNewTbl.Items[i].m_swID));//AAV
      End;
      m_pDB.AddTMTarPeriodTable(pOldTbl.Items[i]);
     End;
    End;
End;
{
TM_TARIFF = packed record
     m_swID       : Word;
     m_swTID      : Word;
     m_swTTID     : Word;
     m_sName      : String[100];
     m_dtTime0    : TDateTime;
     m_dtTime1    : TDateTime;
     m_sbyEnable  : Byte;
    End;

}
procedure CL3TariffEditor.AddRecordToGrid(nIndex:Integer;pTbl:PTM_TARIFF);
Var
   nY : Integer;
   nVisible : Integer;
Begin
    nY := nIndex+1;
    nVisible := round(FsgGrid.Height/21);
    if (nY-nVisible)>0  then FsgGrid.TopRow := nY-nVisible;
    with pTbl^ do Begin
     FsgGrid.Cells[0,nY] := IntToStr(nY);
     FsgGrid.Cells[1,nY] := IntToStr(m_swID);
     FsgGrid.Cells[2,nY] := IntToStr(m_swPTID);
     FsgGrid.Cells[3,nY] := IntToStr(m_swZoneID);
     FsgGrid.Cells[4,nY] := IntToStr(m_swTID);
     FsgGrid.Cells[5,nY] := IntToStr(m_swTID);
     //FsgGrid.Cells[5,nY] := m_nPTariffList.Strings[m_swPTID];
     //FsgGrid.Cells[5,nY] := pTbl.;
     FsgGrid.Cells[6,nY] := m_sName;
     FsgGrid.Cells[7,nY] := TimeToStr(m_dtTime0);
     FsgGrid.Cells[8,nY] := TimeToStr(m_dtTime1);
     FsgGrid.Cells[9,nY] := FloatToStr(m_sfKoeff);
     FsgGrid.Cells[10,nY] := m_nEsNoList.Strings[m_sbyEnable];
    End;
End;
procedure CL3TariffEditor.OnSetGrid;
Begin
    ExecSetGrid;
End;
procedure CL3TariffEditor.OnSaveGrid;
Var
    i : Integer;
    pTbl:TM_TARIFF;
Begin
    for i:=1 to FsgGrid.RowCount-1 do
    Begin
     if FsgGrid.Cells[3,i]='' then break;
     pTbl.m_swID := i;
     GetGridRecord(pTbl);
     m_pDB.AddTMTarPeriodTable(pTbl);
     //if m_pDB.AddTMTarPeriodTable(pTbl)=True then SetIndex(pTbl.m_swTID);
    End;
    ExecSetGrid;
End;
function CL3TariffEditor.FindFreeRow(nIndex:Integer):Integer;
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
procedure CL3TariffEditor.GetGridRecord(var pTbl:TM_TARIFF);
Var
    i : Integer;
    str : String;
Begin
    i := pTbl.m_swID;
    with pTbl do Begin
     SetDefaultRow(i);
     m_swID       := StrToInt(FsgGrid.Cells[1,i]);
     m_swPTID     := StrToInt(FsgGrid.Cells[2,i]);
     m_swZoneID     := StrToInt(FsgGrid.Cells[3,i]);
     m_swTID      := StrToInt(FsgGrid.Cells[4,i]);
     m_sName      := FsgGrid.Cells[6,i];
     m_dtTime0    := StrToTime(FsgGrid.Cells[7,i]);
     m_dtTime1    := StrToTime(FsgGrid.Cells[8,i]);
     m_sfKoeff    := StrToFloat(FsgGrid.Cells[9,i]);
     m_sbyEnable := m_nEsNoList.IndexOf(FsgGrid.Cells[10,i]);
    End;
End;
procedure CL3TariffEditor.OnAddRow;
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
procedure CL3TariffEditor.OnCloneRow;
Var
    nIndex : Integer;
    pTbl   : TM_TARIFF;
Begin
    if m_nRowIndex<>-1 then
    if m_nRowIndex<=FindFreeRow(3)-1 then
    Begin
     pTbl.m_swID   := m_nRowIndex;
     GetGridRecord(pTbl);
     //pTbl.m_swTID := GenIndexSv;
     AddRecordToGrid(FindFreeRow(3)-1,@pTbl);
    End;
End;   // t1 Полупиковая зона
       // t2 Ночная
       // t3 Пиковая
       //
procedure CL3TariffEditor.SetDefaultRow(i:Integer);
Begin
    if FsgGrid.Cells[1,i]='' then FsgGrid.Cells[1,i] := '-1';
    if FsgGrid.Cells[2,i]='' then FsgGrid.Cells[2,i] := '0';
    if FsgGrid.Cells[3,i]='' then FsgGrid.Cells[3,i] := IntToStr(m_nMasterIndex);
    if FsgGrid.Cells[4,i]='' then FsgGrid.Cells[4,i] := '0';
    if FsgGrid.Cells[5,i]='' then FsgGrid.Cells[5,i] := m_nPTariffList.Strings[0];
    if FsgGrid.Cells[6,i]='' then FsgGrid.Cells[6,i] := 'Полупиковая зона';
    if FsgGrid.Cells[7,i]='' then FsgGrid.Cells[7,i] := TimeToStr(Now);
    if FsgGrid.Cells[8,i]='' then FsgGrid.Cells[8,i] := TimeToStr(Now);
    if FsgGrid.Cells[9,i]='' then FsgGrid.Cells[9,i] := FloatToStr(1);
    if FsgGrid.Cells[10,i]=''then FsgGrid.Cells[10,i]:= m_nEsNoList.Strings[1];
End;
procedure CL3TariffEditor.OnClickGrid(Sender: TObject; ARow, ACol: Integer);
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
procedure CL3TariffEditor.OnDelRow;
Var
    nFind : Integer;
Begin
    if m_nAmRecords=FindFreeRow(3)-1 then
    Begin
     if (m_nIndex<>-1)and(m_nRowIndex>0) then
     Begin
      FreeAllIndex;
      //m_pDB.DelTMTarPeriodTable(m_nMasterIndex,m_nIndex);
      m_pDB.DelTMTarPeriodTable(m_nMasterIndex,StrToInt(FsgGrid.Cells[1,m_nRowIndex]));
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
     // SetHigthGrid(FsgGrid^,20);
     End;
    End;
End;
procedure CL3TariffEditor.OnDelAllRow;
Begin
    m_pDB.DelTMTarPeriodTable(m_nMasterIndex,-1);
    FreeAllIndex;
    ExecSetGrid;
End;
//Init Layer
procedure CL3TariffEditor.OnInitLayer;
Begin
    //ExecSetTree;
    ExecInitLayer;
End;
//Index Generator
function  CL3TariffEditor.GenIndex:Integer;
Var
    i : Integer;
Begin
    {
    for i:=0 to MAX_MTYPE do
    if m_blMTypeIndex[i]=True then
    Begin
     Result := i;
     exit;
    End;
    }
    Result := -1;
End;
function  CL3TariffEditor.GenIndexSv:Integer;
Begin
    Result := SetIndex(GenIndex);
End;
function CL3TariffEditor.SetIndex(nIndex : Integer):Integer;
Begin
    //m_blMTypeIndex[nIndex] := False;
    Result := nIndex;
End;
Procedure CL3TariffEditor.FreeIndex(nIndex : Integer);
Begin
    //m_blMTypeIndex[nIndex] := True;
End;
Procedure CL3TariffEditor.FreeAllIndex;
Var
    i : Integer;
Begin
    //for i:=0 to MAX_MTYPE do
    //m_blMTypeIndex[i] := True;
End;
procedure CL3TariffEditor.OnExecute(Sender: TObject);
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
{
FsgGrid.Cells[4,0]  := 'Название';
    FsgGrid.Cells[5,0]  := 'Комментарий';
    FsgGrid.Cells[6,0]  := 'Начало периода';
    FsgGrid.Cells[7,0]  := 'Окончание периода';
    FsgGrid.Cells[8,0]  := 'Тарифный коэффициент';
    FsgGrid.Cells[9,0]  := 'Активность';
}
procedure CL3TariffEditor.OnComboChandge(Sender: TObject; ACol, ARow,
               AItemIndex: Integer; ASelection: String);
Begin
    if ACol=5 then
    Begin
     FsgGrid.Cells[3,ARow] := IntToStr(AItemIndex);
     if AItemIndex=0 then
     Begin
      FsgGrid.Cells[2,ARow] := '0';
      FsgGrid.Cells[6,ARow] := 'Сумма всех тарифов';
      FsgGrid.Cells[7,ARow] := '00:00:00';
      FsgGrid.Cells[8,ARow] := '23:59:59';
     End;
     if AItemIndex=1 then
     Begin
      FsgGrid.Cells[2,ARow] := '1';
      FsgGrid.Cells[6,ARow] := 'Полупиковая зона';
      FsgGrid.Cells[7,ARow] := '06:00:00';
      FsgGrid.Cells[8,ARow] := '08:00:00';
     End;
     if AItemIndex=2 then
     Begin
      FsgGrid.Cells[2,ARow] := '2';
      FsgGrid.Cells[6,ARow] := 'Пиковая зона';
      FsgGrid.Cells[7,ARow] := '08:00:00';
      FsgGrid.Cells[8,ARow] := '11:00:00';
     End;
     if AItemIndex=3 then
     Begin
      FsgGrid.Cells[2,ARow] := '1';
      FsgGrid.Cells[6,ARow] := 'Полупиковая зона';
      FsgGrid.Cells[7,ARow] := '11:00:00';
      FsgGrid.Cells[8,ARow] := '23:00:00';
     End;
     if AItemIndex=4 then
     Begin
      FsgGrid.Cells[2,ARow] := '3';
      FsgGrid.Cells[6,ARow] := 'Ночная зона';
      FsgGrid.Cells[7,ARow] := '23:00:00';
      FsgGrid.Cells[8,ARow] := '06:00:00';
     End;
    End;
End;
//Color And Control
procedure CL3TariffEditor.OnChannelGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
     OnGlGetCellColor(Sender,ARow,ACol,AState,ABrush,AFont);
end;
procedure CL3TariffEditor.OnChannelGetCellType(Sender: TObject; ACol, ARow: Integer;var AEditor: TEditorType);
begin
    with FsgGrid^ do
    case ACol of
     5:Begin
        //AEditor := edComboList;
        //combobox.items.loadfromfile(m_strCurrentDir+'TariffType.dat');
       End;
     10:Begin
        AEditor := edComboList;
        combobox.items.loadfromfile(m_strCurrentDir+'Active.dat');
       End;
    end;
end;
function CL3TariffEditor.GetComboIndex(cbCombo:TComboBox;str:String):Integer;
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

