unit knsl3tartypeeditor;
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,Messages,
  Graphics, Controls, Forms, Dialogs, Spin,
  Grids, BaseGrid, AdvGrid,utlbox,utlconst,utldatabase,knsl1module,
  knsl3tariffeditor,knsl2treeloader,knsl5tracer,knsl5config,knsl3EventBox;
type
    CL3TarTypeEditor = class
    Private
     FTreeModule    : PTTreeView;
     m_byTrState    : Byte;
     m_byTrEditMode : Byte;
     m_nPageIndex   : Integer;
     m_nIndex       : Integer;
     m_nIDIndexEx   : Integer;
     m_nRowIndex    : Integer;
     m_nRowIndexEx  : Integer;
     m_nColIndex    : Integer;
     m_nIDIndex     : Integer;
     m_nAmRecords   : Integer;
     FMasterIndex   : Integer;
     FMasterIndex1  : Integer;
     m_strCurrentDir: String;
     m_nTypeList    : TStringList;
     FsgGrid        : PTAdvStringGrid;
     FsgCGrid       : PTAdvStringGrid;
     FcbCmdCombo    : PTComboBox;
     FChild         : CL3TariffEditor;
     FTreeLoader    : PCTreeLoader;
     m_sTarJoin     : STATIFJOINTAG;
     m_nTatiffName  : TStringList;
     m_pPSZTbl      : PTM_SZNTARIFFS;
     m_pPPLTbl      : PTM_PLANES;
     m_pTrTTbl      : TM_TARIFFSS;
     m_blComboCh    : Boolean;
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

     procedure AddRecordToGrid(nIndex:Integer;pTbl:PTM_TARIFFS);
     function  SetIndex(nIndex : Integer):Integer;
     function  GenIndex:Integer;
     function  GenIndexSv:Integer;
     procedure FreeIndex(nIndex : Integer);
     Procedure FreeAllIndex;
     procedure GetGridRecord(var pTbl:TM_TARIFFS);
     function  GetComboIndex(cbCombo:TComboBox;str:String):Integer;
     function  SetDefaultRow(i:Integer):Integer;
     function  IndexGen(nPlane,nSZone,nTDay,nZone:Integer):Dword;
     procedure InitComboSz;
     procedure InitComboPl;
     function  GetNameSz(nIndex:Integer):String;
     function  GetNamePl(nIndex:Integer):String;
     procedure RefreshIndex;
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
     procedure OnComboChTType(Sender: TObject; ACol, ARow,
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
     procedure OnSetForAll;
     procedure SetEdit;
     procedure OnSetAllSyzon;
     procedure OnSetAllTDay;
     procedure OnSetAllTPlanPattern;
     procedure OnSetEdition;
     procedure OnLoadTariffs;
     procedure OpenInfo;
     procedure CloseInfo;
    Public
     property PTreeModule :PTTreeView       read FTreeModule           write FTreeModule;
     property PsgGrid     :PTAdvStringGrid  read FsgGrid               write FsgGrid;
     property PsgCGrid    :PTAdvStringGrid  read FsgCGrid              write FsgCGrid;
     property PcbCmdCombo :PTComboBox       read FcbCmdCombo           write FcbCmdCombo;
     property PPageIndex  :Integer          read m_nPageIndex          write m_nPageIndex;
     property PIndex      :Integer          read m_nIndex              write m_nIndex;
     property PMasterIndex:Integer          read FMasterIndex          write FMasterIndex;
     property PMasterIndex1:Integer         read FMasterIndex1         write FMasterIndex1;
     property PChild      : CL3TariffEditor read FChild                write FChild;
     property PTreeLoader :PCTreeLoader     read FTreeLoader           write FTreeLoader;
     property PPlane      :Integer          read m_sTarJoin.m_swPLID   write m_sTarJoin.m_swPLID;
     property PSZone      :Integer          read m_sTarJoin.m_swSZNID  write m_sTarJoin.m_swSZNID;
     property PTDay       :Integer          read m_sTarJoin.m_swTDayID write m_sTarJoin.m_swTDayID;
     property PSZTm0      :TDateTime        read m_sTarJoin.m_swSZTM0  write m_sTarJoin.m_swSZTM0;
     property PSZTm1      :TDateTime        read m_sTarJoin.m_swSZTM1  write m_sTarJoin.m_swSZTM1;
     property PPSZTbl     :PTM_SZNTARIFFS   read m_pPSZTbl             write m_pPSZTbl;
     property PPPLTbl     :PTM_PLANES       read m_pPPLTbl             write m_pPPLTbl;

    End;
    PCL3TarTypeEditor =^ CL3TarTypeEditor; 
implementation
constructor CL3TarTypeEditor.Create;
Begin

End;
{
TM_TARIFF = packed record
     m_swID    : Word;
     m_swTID   : Word;
     m_swTTID  : Word;
     m_dtTime0 : TDateTime;
     m_dtTime1 : TDateTime;
     m_sName   : String[100];
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
  MAX_TDAY   = 5;
  MAX_PLANE  = 10;
  MAX_TRTYPE = 50;
}

destructor CL3TarTypeEditor.Destroy;
begin
  if FChild <> nil then FreeAndNil(FChild);
  if m_nTatiffName <> nil then FreeAndNil(m_nTatiffName);

  inherited;
end;

procedure CL3TarTypeEditor.Init;
Var
    i,j,k,l : Integer;
Begin
    m_strCurrentDir := ExtractFilePath(Application.ExeName) + '\\Settings\\';
    PPlane := 0;
    for i:=0 to MAX_SZONE do
    for j:=0 to MAX_TDAY do
    for k:=0 to MAX_PLANE do
    for l:=0 to MAX_TRTYPE do m_blTarTypeIndex[i,j,k,l] := True;
    m_nTatiffName       := TStringList.Create;
    m_nTatiffName.LoadFromFile(m_strCurrentDir+'ParamType.dat');
    //FMasterIndex        := 0;
    //FMasterIndex1       := 0;
    m_blComboCh         := False;
    m_nRowIndex         := -1;
    m_nRowIndexEx       := 1;
    m_nColIndex         := 1;
    m_nIDIndex          := 2;
    m_nIDIndexEx        := 3;
    FsgGrid.Color       := KNS_NCOLOR;
    FsgGrid.ColCount    := 11;
    FsgGrid.RowCount    := 60;
    FsgGrid.Cells[0,0]  := '№/T';
    FsgGrid.Cells[1,0]  := 'ID';
    FsgGrid.Cells[2,0]  := 'Зона';
    FsgGrid.Cells[3,0]  := 'Тип';
    FsgGrid.Cells[4,0]  := 'Тарифный план';
    FsgGrid.Cells[5,0]  := 'Сезон';
    FsgGrid.Cells[6,0]  := 'Тип дня';
    FsgGrid.Cells[7,0]  := 'Название';
    //FsgGrid.Cells[8,0]  := 'Тарифицируемый параметр';
    FsgGrid.Cells[8,0]  := 'Начало действия';
    FsgGrid.Cells[9,0]  := 'Окончание действия';
    FsgGrid.Cells[10,0] := 'Активность';
    FsgGrid.ColWidths[0]:= 30;
    FsgGrid.ColWidths[1]:= 0;
    FsgGrid.ColWidths[2]:= 0;
    FsgGrid.ColWidths[3]:= 0;
    FsgGrid.ColWidths[4]:= 150;
    FsgGrid.ColWidths[5]:= 200;
    FsgGrid.ColWidths[6]:= 75;
    FsgGrid.ColWidths[7]:= 170;
    FsgGrid.ColWidths[8]:= 0;
    FsgGrid.ColWidths[9]:= 0;
    m_nTehnoLen         := 3*0+150+200+75+170+0+0;
    //FsgGrid.ColWidths[8]:= 155;
    SetHigthGrid(FsgGrid^,20);

    ExecSetGrid;
    FChild             := CL3TariffEditor.Create;
    //if FsgGrid.Cells[2,1]<>'' then
    //FChild.PMasterIndex:= StrToInt(FsgGrid.Cells[2,1]);
    //FChild.Init;
End;
procedure CL3TarTypeEditor.OpenInfo;
Begin
    FsgGrid.ColWidths[0]:= 30;
    FsgGrid.ColWidths[1]:= 30;
    FsgGrid.ColWidths[2]:= 30;
    FsgGrid.ColWidths[3]:= 30;
    FsgGrid.ColWidths[4]:= 150;
    FsgGrid.ColWidths[5]:= 200;
    FsgGrid.ColWidths[6]:= 75;
    FsgGrid.ColWidths[7]:= 170;
    FsgGrid.ColWidths[8]:= 0;
    FsgGrid.ColWidths[9]:= 0;
    m_nTehnoLen         := 3*30+150+200+75+170+0+0;
    OnFormResize;
End;
procedure CL3TarTypeEditor.CloseInfo;
Begin
    FsgGrid.ColWidths[0]:= 30;
    FsgGrid.ColWidths[1]:= 0;
    FsgGrid.ColWidths[2]:= 0;
    FsgGrid.ColWidths[3]:= 0;
    FsgGrid.ColWidths[4]:= 150;
    FsgGrid.ColWidths[5]:= 200;
    FsgGrid.ColWidths[6]:= 75;
    FsgGrid.ColWidths[7]:= 170;
    FsgGrid.ColWidths[8]:= 0;
    FsgGrid.ColWidths[9]:= 0;
    m_nTehnoLen         := 3*0+150+200+75+170+0+0;
    OnFormResize;
End;
procedure CL3TarTypeEditor.SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
Var
    i : Integer;
Begin
   // for i:=0 to sgGrid.RowCount-1 do Begin sgGrid.Cells[0,i+1] := IntToStr(i+1); sgGrid.RowHeights[i]:= nHigth;End;
End;
procedure CL3TarTypeEditor.OnFormResize;
Var
    i : Integer;
Begin
    for i:=10 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-(m_nTehnoLen)-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1-9));
    FChild.OnFormResize;
End;
procedure CL3TarTypeEditor.InitComboSz;
Var
    i : Integer;
Begin
    if m_pPSZTbl.Count<>0 then
    Begin
     FsgGrid.Combobox.Items.Clear;
     for i:=0 to m_pPSZTbl.Count-1 do
     FsgGrid.Combobox.Items.Add(m_pPSZTbl.Items[i].m_swSZNName+':'+DateTimeToStr(m_pPSZTbl.Items[i].m_snFTime));
    End;
End;
procedure CL3TarTypeEditor.InitComboPl;
Var
    i : Integer;
Begin
    Begin
     FsgGrid.Combobox.Items.Clear;
     for i:=0 to m_pPPLTbl.Count-1 do
     FsgGrid.Combobox.Items.Add(m_pPPLTbl.Items[i].m_sName);
    End;
End;
procedure CL3TarTypeEditor.SetEdit;
Var
    i : Integer;
Begin
    m_nRowIndex := -1;
    FreeAllIndex;
    if m_pDB.GetTMTarifsTable(PPLane,PSZone,PTDay,m_pTrTTbl)=True then for i:=0 to m_pTrTTbl.Count-1 do SetIndex(m_pTrTTbl.Items[i].m_swTTID);
End;
function  CL3TarTypeEditor.IndexGen(nPlane,nSZone,nTDay,nZone:Integer):Dword;
Begin
    Result := (nPlane shl 24)+(nSZone shl 16)+(nTDay shl 8)+nZone;
End;
procedure CL3TarTypeEditor.RefreshIndex;
Var
    i,nZone : Integer;
Begin
    for i:=1 to FsgGrid.RowCount-1 do
    if FsgGrid.Cells[m_nIDIndex,i]<>'' then
    Begin
     nZone := StrToInt(FsgGrid.Cells[m_nIDIndexEx,i]);
     FsgGrid.Cells[m_nIDIndex,i] := IntToStr(IndexGen(PPlane,PSZone,PTDay,nZone));
    End;
End;
//Edit Add Del Request
procedure CL3TarTypeEditor.OnEditNode;
begin
end;
procedure CL3TarTypeEditor.OnAddNode;
begin
end;
procedure CL3TarTypeEditor.OnDeleteNode;
Begin
End;
//Edit Add Del Execute
procedure CL3TarTypeEditor.ExecSetEditData(nIndex:Integer);
Begin
    TraceL(1,0,'ExecSetEditData.');
End;
procedure CL3TarTypeEditor.ExecEditData;
Begin
    TraceL(1,0,'ExecEditData.');
End;
procedure CL3TarTypeEditor.ExecAddData;
Begin
    TraceL(1,0,'ExecAddData.');
End;
procedure CL3TarTypeEditor.ExecDelData;
Begin
    TraceL(1,0,'ExecDelData.');
End;
procedure CL3TarTypeEditor.ExecInitLayer;
Begin
    TraceL(1,0,'ExecInitLayer.');
    //mL2Module.Init;
End;
//Tree Reload
procedure CL3TarTypeEditor.ExecSetTree;
Begin
    TraceL(1,0,'ExecSetTree.');
    //FTreeLoader.LoadTree;
End;
//Grid Routine
procedure CL3TarTypeEditor.ExecSelRowGrid;
Begin
    FsgGrid.SelectRows(FindRow(IntToStr(m_nIndex)),1);
    FsgGrid.Refresh;
    ViewChild(m_nIndex);
End;
function CL3TarTypeEditor.FindRow(str:String):Integer;
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
procedure CL3TarTypeEditor.OnSetAllSyzon;
Var
    pOldTbl : TM_TARIFFSS;
    i,j,k,nOldID,nNewID : Integer;
Begin
     for i:=0 to SZN_HOLY_DAY do
     //for i:=0 to 0 do
     if m_pDB.GetTMTarifsTable(PPLane,PSZone,i,pOldTbl)=True then
     Begin
      for j:=0 to m_pPSZTbl.Count-1 do
       Begin
        for k:=0 to pOldTbl.Count-1 do
         Begin
          //nOldID := pOldTbl.Items[k].m_swZoneID;
          nOldID := IndexGen(PPLane,PSZone,i,pOldTbl.Items[k].m_swTTID);;
          if PSZone<>m_pPSZTbl.Items[j].m_swSZNID then
          Begin
           nNewID := IndexGen(PPLane,m_pPSZTbl.Items[j].m_swSZNID,i,pOldTbl.Items[k].m_swTTID);
           //if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'i:'+IntToStr(i)+' j:'+IntToStr(j)+' k:'+IntToStr(k)+' '+m_pPSZTbl.Items[PSZone].m_swSZNName+' для '+m_pPSZTbl.Items[j].m_swSZNName+' ('+IntToStr(nOldID)+')'+'OLD_Z:'+pOldTbl.Items[k].m_sName +' NEW_Z:'+IntToStr(nNewID)+' TTID:'+IntToStr(pOldTbl.Items[k].m_swTTID));//AAV
           pOldTbl.Items[k].m_swZoneID := nNewID;
           pOldTbl.Items[k].m_swSZNID  := m_pPSZTbl.Items[j].m_swSZNID;
           pOldTbl.Items[k].m_dtTime0  := m_pPSZTbl.Items[j].m_snFTime;
           pOldTbl.Items[k].m_dtTime1  := m_pPSZTbl.Items[j].m_snETime;
           pOldTbl.Items[k].m_swTDayID := i;
           m_pDB.AddTMTarifTable(pOldTbl.Items[k]);
           FChild.OnSaveNewIndex(nOldID,nNewID);
          End;
         End;
       End;
     End;
End;
procedure CL3TarTypeEditor.OnSetAllTDay;
Var
    pOldTbl : TM_TARIFFSS;
    i,j,nOldID,nNewID : Integer;
Begin
    if m_pDB.GetTMTarifsTable(PPLane,PSZone,PTDay,pOldTbl)=True then
    for i:=0 to SZN_HOLY_DAY do
    Begin
     for j:=0 to pOldTbl.Count-1 do
     Begin
      nOldID := pOldTbl.Items[j].m_swZoneID;
      nNewID := IndexGen(PPLane,PSZone,i,pOldTbl.Items[j].m_swTTID);
      pOldTbl.Items[j].m_swZoneID := nNewID;
      pOldTbl.Items[j].m_swTDayID := i;
      m_pDB.AddTMTarifTable(pOldTbl.Items[j]);
      FChild.OnSaveNewIndex(nOldID,nNewID);
     End;
    End;
End;

procedure CL3TarTypeEditor.OnSetAllTPlanPattern;
var
   pOldTbl             : TM_TARIFFSS;
   i, nNewID, nOldID   : integer;
begin
   if m_pDB.GetTMTarifsTable(0, 0, 0, pOldTbl)=True then
   begin
     for i := 0 to pOldTbl.Count - 1 do
     begin
       nNewID := IndexGen(PPLane,0,0,pOldTbl.Items[i].m_swTTID);
       nOldID := pOldTbl.Items[i].m_swZoneID;
       pOldTbl.Items[i].m_swZoneID := nNewID;
       pOldTbl.Items[i].m_swTDayID := 0;
       pOldTbl.Items[i].m_swPLID   := PPLane;
       m_pDB.AddTMTarifTable(pOldTbl.Items[i]);
       FChild.OnSaveNewIndex(nOldID,nNewID);
     end;
   end;
end;

procedure CL3TarTypeEditor.OnSetEdition;
Begin

End;
procedure CL3TarTypeEditor.OnSetForAll;
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
procedure CL3TarTypeEditor.OnLoadTariffs;
Var
    i : Integer;
Begin
    m_nTatiffName.Clear;
    m_nTatiffName.LoadFromFile(m_strCurrentDir+'ParamType.dat');
    FsgGrid.ClearNormalCells;
    FreeAllIndex;
    for i:=0 to m_nTatiffName.Count-1 do
    SetIndex(SetDefaultRow(i+1));
End;
procedure CL3TarTypeEditor.ViewChild(nIndex:Integer);
Begin
    if m_blCL3TarTypeEditor=False then 
    if FChild<>Nil then
    Begin
     FChild.PMasterIndex := nIndex;
     FChild.ExecSetGrid;
    End;
End;
procedure CL3TarTypeEditor.ExecSetGrid;
Var
    i : Integer;
Begin
    FsgGrid.ClearNormalCells;
    //FreeAllIndex;
    if m_pDB.GetTMTarifsTable(PPLane,PSZone,PTDay,m_pTrTTbl)=True then
    Begin
     m_nAmRecords := m_pTrTTbl.Count;
     for i:=0 to m_pTrTTbl.Count-1 do
     Begin
      SetIndex(m_pTrTTbl.Items[i].m_swTTID);
      AddRecordToGrid(i,@m_pTrTTbl.Items[i]);
     End;
     ViewDefault;
    End;
End;
procedure CL3TarTypeEditor.ViewDefault;
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
TM_TARIFF = packed record
     m_swID       : Word;
     m_swPTID     : Word;
     m_swTID      : Word;
     m_swTTID     : Word;
     m_sName      : String[100];
     m_dtTime0    : TDateTime;
     m_dtTime1    : TDateTime;
     m_sfKoeff    : Double;
     m_sbyEnable  : Byte;
    End;
    PTM_TARIFF =^ TM_TARIFF;
    TM_TARIFFS = packed record
     m_swID       : Word;
     m_swTTID     : Word;
     m_swPLID     : Integer;
     m_swTDayID   : Integer;
     m_swSZNID    : Integer;
     m_sName      : String[100];
     m_swCMDID    : Word;
     m_dtTime0    : TDateTime;
     m_dtTime1    : TDateTime;
     m_sbyEnable  : Byte;
     Count        : Word;
     Items        : array of TM_TARIFF;
    End;
    PTM_TARIFFS =^ TM_TARIFFS;
    TM_TARIFFSS = packed record
     Count     : Word;
     Items     : array of TM_TARIFFS;
    End;
}
procedure CL3TarTypeEditor.AddRecordToGrid(nIndex:Integer;pTbl:PTM_TARIFFS);
Var
   nY : Integer;
   nVisible : Integer;
Begin
    nY := nIndex+1;
    { m_swPLID     : Integer;
     m_swSZNID    : Integer;}
    nVisible := round(FsgGrid.Height/21);
    if (nY-nVisible)>0  then FsgGrid.TopRow := nY-nVisible;
    with pTbl^ do Begin
     FsgGrid.Cells[0,nY] := IntToStr(nY);
     FsgGrid.Cells[1,nY] := IntToStr(m_swID);
     FsgGrid.Cells[2,nY] := IntToStr(m_swZoneID);
     FsgGrid.Cells[3,nY] := IntToStr(m_swTTID);
     FsgGrid.Cells[4,nY] := GetNamePl(m_swPLID);
     FsgGrid.Cells[5,nY] := GetNameSz(m_swSZNID);
     FsgGrid.Cells[6,nY] := m_nWorkDay.Strings[m_swTDayID];
     FsgGrid.Cells[7,nY] := m_sName;
     //FsgGrid.Cells[8,nY] := m_nParamList.Strings[m_swCMDID];
     FsgGrid.Cells[8,nY] := DateToStr(m_dtTime0);
     FsgGrid.Cells[9,nY] := DateToStr(m_dtTime1);
     FsgGrid.Cells[10,nY]:= m_nEsNoList.Strings[m_sbyEnable];
    End;
End;
procedure CL3TarTypeEditor.OnSetGrid;
Begin
    ExecSetGrid;
End;
procedure CL3TarTypeEditor.OnSaveGrid;
Var
    i : Integer;
    pTbl:TM_TARIFFS;
Begin
    for i:=1 to FsgGrid.RowCount-1 do
    Begin
     if FsgGrid.Cells[3,i]='' then break;
     pTbl.m_swID := i;
     GetGridRecord(pTbl);
     if m_pDB.AddTMTarifTable(pTbl)=True then SetIndex(pTbl.m_swTTID);
     if m_blComboCh=True then FChild.OnSaveNewIndex(m_pTrTTbl.Items[i-1].m_swZoneID,pTbl.m_swZoneID);
    End;
    m_blComboCh := False;
    ExecSetGrid;
End;
function CL3TarTypeEditor.FindFreeRow(nIndex:Integer):Integer;
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
procedure CL3TarTypeEditor.GetGridRecord(var pTbl:TM_TARIFFS);
Var
    i : Integer;
    str : String;
Begin
    i := pTbl.m_swID;
    with pTbl do Begin
     SetDefaultRow(i);
     m_swID       := StrToInt(FsgGrid.Cells[1,i]);
     m_swZoneID   := StrToInt(FsgGrid.Cells[2,i]);
     m_swTTID     := StrToInt(FsgGrid.Cells[3,i]);
     m_swPLID     := PPlane;
     m_swSZNID    := PSZone;
     m_swTDayID   := m_nWorkDay.IndexOf(FsgGrid.Cells[6,i]);
     m_sName      := FsgGrid.Cells[7,i];
     m_swCMDID    := 0;
     m_dtTime0    := StrToDate(FsgGrid.Cells[8,i]);
     m_dtTime1    := StrToDate(FsgGrid.Cells[9,i]);
     m_sbyEnable := m_nEsNoList.IndexOf(FsgGrid.Cells[10,i]);
    End;
End;
procedure CL3TarTypeEditor.OnAddRow;
Var
    nIndex : Integer;
Begin
    if m_nRowIndex<>-1 then
    Begin
     SetDefaultRow(m_nRowIndex);
     SetIndex(StrToInt(FsgGrid.Cells[m_nIDIndexEx,m_nRowIndex]));
    End else
    Begin
     nIndex := FindFreeRow(3);
     SetDefaultRow(nIndex);
     SetIndex(StrToInt(FsgGrid.Cells[m_nIDIndexEx,nIndex]));
    End;
End;
procedure CL3TarTypeEditor.OnCloneRow;
Var
    nIndex : Integer;
    pTbl   : TM_TARIFFS;
Begin
    if m_nRowIndex<>-1 then
    if m_nRowIndex<=FindFreeRow(3)-1 then
    Begin
     pTbl.m_swID   := m_nRowIndex;
     GetGridRecord(pTbl);
     pTbl.m_swTTID := GenIndexSv;
     AddRecordToGrid(FindFreeRow(3)-1,@pTbl);
    End;
End;
{
TM_TARIFF = packed record
     m_swID    : Word;
     m_swTID   : Word;
     m_swTTID  : Word;
     m_dtTime0 : TDateTime;
     m_dtTime1 : TDateTime;
     m_sName   : String[100];
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
function CL3TarTypeEditor.SetDefaultRow(i:Integer):Integer;
Var
    nGenID : Integer;
Begin
    if FsgGrid.Cells[1,i]='' then FsgGrid.Cells[1,i] := '-1';
    if FsgGrid.Cells[2,i]='' then
    Begin
     nGenID := GenIndex;
     FsgGrid.Cells[2,i] := IntToStr(IndexGen(PPlane,PSZone,PTDay,nGenID));
    End;
    if FsgGrid.Cells[3,i]='' then FsgGrid.Cells[3,i] := IntToStr(nGenID);
    if FsgGrid.Cells[4,i]='' then FsgGrid.Cells[4,i] := GetNamePl(PPlane); //Plan
    if FsgGrid.Cells[5,i]='' then FsgGrid.Cells[5,i] := GetNameSz(PSZone); //Sez
    if FsgGrid.Cells[6,i]='' then FsgGrid.Cells[6,i] := m_nWorkDay.Strings[PTDay]; //TDay
    if FsgGrid.Cells[7,i]='' then if i<=m_nTatiffName.Count then FsgGrid.Cells[7,i] := m_nTatiffName.Strings[i-1] else FsgGrid.Cells[7,i]:='Тарифицируемый параметр №'+IntToStr(i);
    if FsgGrid.Cells[8,i]='' then FsgGrid.Cells[8,i] := DateTimeToStr(PSZTm0);
    if FsgGrid.Cells[9,i]='' then FsgGrid.Cells[9,i] := DateTimeToStr(PSZTm1);
    if FsgGrid.Cells[10,i]='' then FsgGrid.Cells[10,i] := m_nEsNoList.Strings[1];
    Result := nGenID;
End;
procedure CL3TarTypeEditor.OnClickGrid(Sender: TObject; ARow, ACol: Integer);
Begin
    m_nRowIndex := -1;
    m_nRowIndexEx := -1;
    m_nColIndex   := ACol;
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
procedure CL3TarTypeEditor.OnComboChTType(Sender: TObject; ACol, ARow,
  AItemIndex: Integer; ASelection: String);
begin
    if (ACol<>0)and(ARow<>0)then
    Begin
     m_nRowIndex := ARow;
     if ACol=4 then
     Begin
      if AItemIndex<m_pPPLTbl.Count then
      PPlane := m_pPPLTbl.Items[AItemIndex].m_swPLID;
     End else
     if ACol=5 then
     Begin
      if AItemIndex<m_pPSZTbl.Count then
      Begin
       PSZone := m_pPSZTbl.Items[AItemIndex].m_swSZNID;
       PSZTm0 := m_pPSZTbl.Items[AItemIndex].m_snFTime;
       PSZTm1 := m_pPSZTbl.Items[AItemIndex].m_snETime;
       m_nColIndex:=8;FsgGrid.Cells[m_nColIndex,m_nRowIndex] := DateTimeToStr(PSZTm0);OnSetForAll;
       m_nColIndex:=9;FsgGrid.Cells[m_nColIndex,m_nRowIndex] := DateTimeToStr(PSZTm1);OnSetForAll;
      End;
     End else
     if ACol=6 then
     Begin
      if AItemIndex<m_pPSZTbl.Count then
      PTDay := AItemIndex;
     End;
     m_nColIndex := ACol;
     FsgGrid.Cells[m_nColIndex,m_nRowIndex] := ASelection;
     if (ACol=4)or(ACol=5)or(ACol=6) then
     Begin
      m_blComboCh := True;
      OnSetForAll;
      RefreshIndex;
     End;
    End;
end;
procedure CL3TarTypeEditor.OnDelRow;
Var
    nFind : Integer;
Begin
    if m_nAmRecords=FindFreeRow(3)-1 then
    Begin
     if m_nIndex<>-1 then
     Begin
      nFind := StrToInt(FsgGrid.Cells[m_nIDIndexEx,m_nRowIndex]);
      m_pDB.DelTMTarifTable(PPlane,PSZone,PTDay,nFind);
      SetEdit;
      ExecSetGrid;
      ViewChild(m_nIndex);
     End;
    End else
    Begin
     if m_nRowIndex<>-1 then
     Begin
      if FsgGrid.Cells[m_nIDIndexEx,m_nRowIndex]<>'' then
      FreeIndex(StrToInt(FsgGrid.Cells[m_nIDIndexEx,m_nRowIndex]));
      FsgGrid.ClearRows(m_nRowIndex,1);
      //SetHigthGrid(FsgGrid^,20);
     End;
    End;
End;
procedure CL3TarTypeEditor.OnDelAllRow;
Begin
    m_pDB.DelTMTarifTable(PPlane,PSZone,PTDay,-1);
    SetEdit;
    ExecSetGrid;
End;
//Init Layer
procedure CL3TarTypeEditor.OnInitLayer;
Begin
    //ExecSetTree;
    ExecInitLayer;
End;
//Index Generator
function  CL3TarTypeEditor.GenIndex:Integer;
Var
    i : Integer;
Begin
    for i:=0 to MAX_TRTYPE do
    if m_blTarTypeIndex[PPlane,PSZone,PTDay,i]=True then
    Begin
     Result := i;
     exit;
    End;
    Result := -1;
End;
function  CL3TarTypeEditor.GenIndexSv:Integer;
Begin
    Result := SetIndex(GenIndex);
End;
function CL3TarTypeEditor.SetIndex(nIndex : Integer):Integer;
Begin
    m_blTarTypeIndex[PPlane,PSZone,PTDay,nIndex] := False;
    Result := nIndex;
End;
Procedure CL3TarTypeEditor.FreeIndex(nIndex : Integer);
Begin
    m_blTarTypeIndex[PPlane,PSZone,PTDay,nIndex] := True;
End;
Procedure CL3TarTypeEditor.FreeAllIndex;
Var
    i : Integer;
Begin
    for i:=0 to MAX_TRTYPE do
    m_blTarTypeIndex[PPlane,PSZone,PTDay,i] := True;
End;
procedure CL3TarTypeEditor.OnExecute(Sender: TObject);
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
procedure CL3TarTypeEditor.OnChannelGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
     OnGlGetCellColor(Sender,ARow,ACol,AState,ABrush,AFont);
end;
procedure CL3TarTypeEditor.OnChannelGetCellType(Sender: TObject; ACol, ARow: Integer;var AEditor: TEditorType);
begin
    with FsgGrid^ do
    case ACol of
     4:Begin
        AEditor := edComboList;
        InitComboPl;
       End;
     5:Begin
        AEditor := edComboList;
        InitComboSz;
       End;
     6:Begin
        AEditor := edComboList;
        combobox.items.loadfromfile(m_strCurrentDir+'WorkDay.dat');
       End;
     7:Begin
        //AEditor := edComboList;
        //combobox.items.loadfromfile(m_strCurrentDir+'ParamType.dat');
       End;
     10:Begin
        AEditor := edComboList;
        combobox.items.loadfromfile(m_strCurrentDir+'Active.dat');
       End;
    end;
end;

//m_pPPLTbl
function CL3TarTypeEditor.GetNamePl(nIndex:Integer):String;
Var
    i : Integer;
Begin
    Result := ' ';
    for i:=0 to m_pPPLTbl.Count-1 do
    Begin
      if m_pPPLTbl.Items[i].m_swPLID=nIndex then
      Begin
       Result := m_pPPLTbl.Items[i].m_sName;
       exit;
      End;
    End;
End;
function CL3TarTypeEditor.GetNameSz(nIndex:Integer):String;
Var
    i : Integer;
Begin
    Result := ' ';
    if m_pPSZTbl=Nil then exit;
    for i:=0 to m_pPSZTbl.Count-1 do
    Begin
      if m_pPSZTbl.Items[i].m_swSZNID=nIndex then
      Begin
       Result := m_pPSZTbl.Items[i].m_swSZNName+' с '+DateTimeToStr(m_pPSZTbl.Items[i].m_snFTime)+' по '+DateTimeToStr(m_pPSZTbl.Items[i].m_snETime);
       exit;
      End;
    End;
End;
function CL3TarTypeEditor.GetComboIndex(cbCombo:TComboBox;str:String):Integer;
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
