unit knsl3vparameditor;
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,Messages,
  Graphics, Controls, Forms, Dialogs, Spin,
  Grids, BaseGrid, AdvGrid,utlbox,utlconst,utldatabase,knsl1module,
  knsl2module,knsl2treeloader,knsl5tracer,knseditexpr,knsl5config;
type


    CL3VParamEditor = class
    Private
     FTreeModule    : PTTreeView;
     m_byTrState    : Byte;
     m_byTrEditMode : Byte;

     m_nIDIndex     : Integer;
     m_nRowIndex    : Integer;
     m_nColIndex    : Integer;
     m_nAmRecords   : Integer;

     FTypeIndex     : Integer;
     FPageIndex     : Integer;
     m_nIndex       : Integer;
     m_nAbonIndex   : Integer;
     m_nMasterIndex : Integer;
     m_nGroupIndex  : Integer;
     m_strCurrentDir: String;
     m_nCmdList     : TStringList;
     m_nSaveList    : TStringList;
     m_nTariffList  : TStringList;
     FComboModule   : PTComboBox;
     FsgGrid        : PTAdvStringGrid;
     FChild         : CL3VParamEditor;
     m_sL2Addr      : array of Integer;
     FTreeLoader    : PCTreeLoader;
     m_sTbl : SL3VMETERTAG;
     m_nTehnoLen    : Integer;
     constructor Create;
     procedure ExecSelRowGrid;
     procedure ViewChild(nIndex:Integer);
     procedure OnExecute(Sender: TObject);
     procedure ExecEditData;
     procedure ExecAddData;
     procedure ExecDelData;

     procedure AddRecordToGrid(nIndex:Integer;pTbl:PSL3PARAMS);
     procedure SetIndex(nIndex : Integer);
     function  GenIndex:Integer;
     procedure FreeIndex(nIndex : Integer);
     procedure FreeAllIndex;
     function  FindFreeRow(nIndex:Integer):Integer;
     procedure GetGridRecord(var pTbl:SL3PARAMS);
     function  GetComboIndex(cbCombo:TComboBox;str:String):Integer;
     procedure SendMSG(byBox,byFor,byType:Byte);
     procedure InitComboTariff;

    Public
     procedure Init;
     destructor Destroy; override;
     procedure InitCombo;
     procedure OnFormResize;
     procedure SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
     procedure OnChannelGetCellColor(Sender: TObject; ARow,
               ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
     procedure OnChannelGetCellType(Sender: TObject; ACol,
               ARow: Integer; var AEditor: TEditorType);
     procedure OnChandgeComboVL3(ACol, ARow,
               AItemIndex: Integer; ASelection: String);
     procedure OnClickGrid(Sender: TObject; ARow, ACol: Integer);
     procedure OnMDownPE(Sender: TObject; Button: TMouseButton;
               Shift: TShiftState; X, Y: Integer);
     procedure OnSetForAllParam;
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
     procedure OnAddAutoVParam;
     procedure OnTimeSynchronize;
     procedure SetEdit;
     procedure OnSetAllGroup;
     procedure OnSetAllInAbon;
     procedure OnSetAllInAbonParam;
     procedure OnSetAllAbon;
     procedure OpenInfo;
     procedure CloseInfo;
    Public
     property PTreeModule  :PTTreeView       read FTreeModule    write FTreeModule;
     property PComboModule :PTComboBox       read FComboModule   write FComboModule;
     property PsgGrid      :PTAdvStringGrid  read FsgGrid        write FsgGrid;
     property PPageIndex   :Integer          read FPageIndex     write FPageIndex;

     property PGroupIndex  :Integer          read m_nGroupIndex  write m_nGroupIndex;
     property PAbonIndex   :Integer          read m_nAbonIndex   write m_nAbonIndex;
     property PIndex       :Integer          read m_nIndex       write m_nIndex;
     property PMasterIndex :Integer          read m_nMasterIndex write m_nMasterIndex;
     property PTypeIndex   :Integer          read FTypeIndex     write FTypeIndex;
     property PChild       :CL3VParamEditor  read FChild         write FChild;
     property PTreeLoader  :PCTreeLoader     read FTreeLoader    write FTreeLoader;
    End;
implementation
constructor CL3VParamEditor.Create;
Begin

End;
//ExtractFilePath(Application.ExeName)
{
     m_swID          : Word;
     m_swVMID        : WORD;
     m_swParamID     : WORD;
     m_sParamExpress : String[30];
     m_fValue        : Single;
     m_fMin          : Single;
     m_fMax          : Single;
     m_dtDateTime    : TDateTime;
     m_sblEnable     : Boolean;
}

destructor CL3VParamEditor.Destroy;
begin
  if m_nTariffList <> nil then FreeAndNil(m_nTariffList);
  if m_nSaveList <> nil then FreeAndNil(m_nSaveList);
  if m_nCmdList <> nil then FreeAndNil(m_nCmdList);
  inherited;
end;

procedure CL3VParamEditor.Init;
Var
    i : Integer;
Begin
    m_strCurrentDir := ExtractFilePath(Application.ExeName) + '\\Settings\\';
    //for i:=0 to MAX_VMETER do m_blVMeterIndex[i] := True;
    m_nTariffList := TStringList.Create;
    m_nCmdList  := TStringList.Create;
    m_nSaveList := TStringList.Create;
    m_nCmdList.LoadFromFile(m_strCurrentDir+'CommandType.dat');
    m_nSaveList.LoadFromFile(m_strCurrentDir+'StateSaveParam.dat');
    //FTreeModule.Color   := KNS_COLOR;
    //FsgGrid.Color       := KNS_NCOLOR;
    FsgGrid.ColCount    := 19;
    FsgGrid.RowCount    := 60;
    m_nIDIndex          := 1;

    FsgGrid.Cells[0,0]  := '�/T';
    FsgGrid.Cells[1,0]  := 'ID';
    FsgGrid.Cells[2,0]  := 'VMID';
    FsgGrid.Cells[3,0]  := '��������';
    FsgGrid.Cells[4,0]  := '���������';
    FsgGrid.Cells[5,0]  := '���.����.';
    FsgGrid.Cells[6,0]  := '�����';
    FsgGrid.Cells[7,0]  := '����.����.';
    FsgGrid.Cells[8,0]  := '��������';
    FsgGrid.Cells[9,0]  := '�����';
    FsgGrid.Cells[10,0] := '������ ���.';
    FsgGrid.Cells[11,0] := '�����';
    FsgGrid.Cells[12,0] := '���������';
    FsgGrid.Cells[13,0] := '��� ��������';
    FsgGrid.Cells[14,0] := '��� �������';
    FsgGrid.Cells[15,0] := '����������';
    FsgGrid.Cells[16,0] := '���������';
    FsgGrid.Cells[17,0] := '���������.';
    FsgGrid.Cells[18,0] := '��� ����.';
    //m_nDataType


    FsgGrid.ColWidths[0]:= 35;
    FsgGrid.ColWidths[1]:= 0;
    FsgGrid.ColWidths[2]:= 0;
    FsgGrid.ColWidths[3]:= 120;
    FsgGrid.ColWidths[4]:= 140;
    FsgGrid.ColWidths[5]:= 0;
    m_nTehnoLen         := 0+0+120+140+0;
 //   SetHigthGrid(FsgGrid^,21);
    InitComboTariff;

    //ExecSetTree;
    //ExpandTree(FTreeModule^,'������');
    //ExecSetGrid;
End;
procedure CL3VParamEditor.OpenInfo;
Begin
    FsgGrid.ColWidths[0]:= 35;
    FsgGrid.ColWidths[1]:= 0;
    FsgGrid.ColWidths[2]:= 35;
    FsgGrid.ColWidths[3]:= 120;
    FsgGrid.ColWidths[4]:= 140;
    FsgGrid.ColWidths[5]:= 0;
    m_nTehnoLen         := 0+35+120+140+0;
    OnFormResize;
End;
procedure CL3VParamEditor.CloseInfo;
Begin
    FsgGrid.ColWidths[0]:= 35;
    FsgGrid.ColWidths[1]:= 0;
    FsgGrid.ColWidths[2]:= 0;
    FsgGrid.ColWidths[3]:= 120;
    FsgGrid.ColWidths[4]:= 140;
    FsgGrid.ColWidths[5]:= 0;
    m_nTehnoLen         := 0+0+120+140+0;
    OnFormResize;
End;
procedure CL3VParamEditor.SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
Var
    i : Integer;
Begin
   // for i:=0 to sgGrid.RowCount-1 do Begin sgGrid.Cells[0,i+1] := IntToStr(i+1); sgGrid.RowHeights[i]:= nHigth;End;
End;
procedure CL3VParamEditor.OnFormResize;
Var
    i : Integer;
Begin
    for i:=6 to FsgGrid.ColCount-1  do
    FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-(m_nTehnoLen)-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1-5));
End;
{
   m_nRowIndex := ARow;
   m_nColIndex := ACol;
}
procedure CL3VParamEditor.OnSetAllGroup;
Var
    nAbon,nGroup,nCmd:Integer;
    strCmd : String;
Begin
    nAbon  := PAbonIndex;
    nGroup := PGroupIndex;
    if m_nRowIndex<>-1 then
    Begin
     nCmd   := m_nCmdList.IndexOf(FsgGrid.Cells[3,m_nRowIndex]);
     if m_nColIndex=10 then strCmd := 'm_stSvPeriod='+IntToStr(m_nSvPeriodList.IndexOf(FsgGrid.Cells[m_nColIndex,m_nRowIndex]));
     if m_nColIndex=12 then strCmd := 'm_sblCalculate='+IntToStr(m_nEsNoList.IndexOf(FsgGrid.Cells[m_nColIndex,m_nRowIndex]));
     if m_nColIndex=13 then strCmd := 'm_sblSaved='+IntToStr(m_nSaveList.IndexOf(FsgGrid.Cells[m_nColIndex,m_nRowIndex]));
     if m_nColIndex=14 then strCmd := 'm_swStatus='+IntToStr(m_nStatusList.IndexOf(FsgGrid.Cells[m_nColIndex,m_nRowIndex]));
     if m_nColIndex=15 then strCmd := 'm_sblEnable='+IntToStr(m_nEsNoList.IndexOf(FsgGrid.Cells[m_nColIndex,m_nRowIndex]));
     if m_nColIndex=18 then strCmd := 'm_snDataType='+IntToStr(m_nDataType.IndexOf(FsgGrid.Cells[m_nColIndex,m_nRowIndex]));
     if strCmd<>'' then m_pDB.SetGroupParamAll(nAbon,nGroup,nCmd,strCmd);
    End;
End;
procedure CL3VParamEditor.OnSetAllInAbon;
Var
    nAbon,nGroup,nCmd:Integer;
    strCmd : String;
Begin
    nAbon  := PAbonIndex;
    nGroup := -1;
    if m_nRowIndex<>-1 then
    Begin
     nCmd   := m_nCmdList.IndexOf(FsgGrid.Cells[3,m_nRowIndex]);
     if m_nColIndex=10 then strCmd := 'm_stSvPeriod='+IntToStr(m_nSvPeriodList.IndexOf(FsgGrid.Cells[m_nColIndex,m_nRowIndex]));
     if m_nColIndex=12 then strCmd := 'm_sblCalculate='+IntToStr(m_nEsNoList.IndexOf(FsgGrid.Cells[m_nColIndex,m_nRowIndex]));
     if m_nColIndex=13 then strCmd := 'm_sblSaved='+IntToStr(m_nSaveList.IndexOf(FsgGrid.Cells[m_nColIndex,m_nRowIndex]));
     if m_nColIndex=14 then strCmd := 'm_swStatus='+IntToStr(m_nStatusList.IndexOf(FsgGrid.Cells[m_nColIndex,m_nRowIndex]));
     if m_nColIndex=15 then strCmd := 'm_sblEnable='+IntToStr(m_nEsNoList.IndexOf(FsgGrid.Cells[m_nColIndex,m_nRowIndex]));
     if m_nColIndex=18 then strCmd := 'm_snDataType='+IntToStr(m_nDataType.IndexOf(FsgGrid.Cells[m_nColIndex,m_nRowIndex]));
     if strCmd<>'' then m_pDB.SetGroupParamAll(nAbon,nGroup,nCmd,strCmd);
    End;
End;
procedure CL3VParamEditor.OnSetAllAbon;
Var
    nAbon,nGroup,nCmd:Integer;
    strCmd : String;
Begin
    nAbon  := -1;
    nGroup := -1;
    if m_nRowIndex<>-1 then
    Begin
     nCmd   := m_nCmdList.IndexOf(FsgGrid.Cells[3,m_nRowIndex]);
     if m_nColIndex=10 then strCmd := 'm_stSvPeriod='+IntToStr(m_nSvPeriodList.IndexOf(FsgGrid.Cells[m_nColIndex,m_nRowIndex]));
     if m_nColIndex=12 then strCmd := 'm_sblCalculate='+IntToStr(m_nEsNoList.IndexOf(FsgGrid.Cells[m_nColIndex,m_nRowIndex]));
     if m_nColIndex=13 then strCmd := 'm_sblSaved='+IntToStr(m_nSaveList.IndexOf(FsgGrid.Cells[m_nColIndex,m_nRowIndex]));
     if m_nColIndex=14 then strCmd := 'm_swStatus='+IntToStr(m_nStatusList.IndexOf(FsgGrid.Cells[m_nColIndex,m_nRowIndex]));
     if m_nColIndex=15 then strCmd := 'm_sblEnable='+IntToStr(m_nEsNoList.IndexOf(FsgGrid.Cells[m_nColIndex,m_nRowIndex]));
     if m_nColIndex=18 then strCmd := 'm_snDataType='+IntToStr(m_nDataType.IndexOf(FsgGrid.Cells[m_nColIndex,m_nRowIndex]));
     if strCmd<>'' then m_pDB.SetGroupParamAll(nAbon,nGroup,nCmd,strCmd);
    End;
End;
procedure CL3VParamEditor.InitCombo;
Var
    pTable : SL2INITITAG;
    i : Integer;
Begin
    if m_pDB.GetMetersIniTable(pTable) then
    Begin
     FsgGrid.Combobox.Items.Clear;
     SetLength(m_sL2Addr,pTable.m_swAmMeter);
     for i:=0 to pTable.m_swAmMeter-1 do
     Begin
      m_sL2Addr[i] := pTable.m_sMeter[i].m_swMID;
      FsgGrid.Combobox.Items.Add(pTable.m_sMeter[i].m_schName);
     End;
    End;
End;
procedure CL3VParamEditor.SetEdit;
Begin
End;
procedure CL3VParamEditor.InitComboTariff;
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
procedure CL3VParamEditor.OnEditNode;
begin
    m_byTrEditMode                  := ND_EDIT;
    ExecSetEditData(m_nIndex);
end;
procedure CL3VParamEditor.OnAddNode;
begin
    m_byTrEditMode                  := ND_ADD;
end;
procedure CL3VParamEditor.OnDeleteNode;
Begin
    m_byTrEditMode                  := ND_DEL;
    ExecSetEditData(m_nIndex);
End;
//Edit Add Del Execute
procedure CL3VParamEditor.ExecSetEditData(nIndex:Integer);
Begin
    TraceL(3,0,'ExecSetEditData.');
End;
procedure CL3VParamEditor.ExecEditData;
Begin
    TraceL(3,0,'ExecEditData.');
End;
procedure CL3VParamEditor.ExecAddData;
Begin
    TraceL(3,0,'ExecAddData.');
End;
procedure CL3VParamEditor.ExecDelData;
Begin
    TraceL(3,0,'ExecDelData.');
    //mL2Module.DelNodeLv(m_nIndex);
    m_pDB.DelVParamTable(m_nMasterIndex,m_nIndex);
    FreeIndex(m_nIndex);
End;
procedure CL3VParamEditor.ExecInitLayer;
Begin
    TraceL(3,0,'ExecInitLayer.');
    //mL2Module.Init;
    //SendMSG(BOX_L3,DIR_L2TOL3,DL_STARTSNDR_IND);
End;
//Tree Reload
procedure CL3VParamEditor.ExecSetTree;
Begin
    TraceL(1,0,'ExecSetTreeData.');
    FTreeLoader.LoadTree;
End;
//Grid Routine
procedure CL3VParamEditor.ExecSetGrid;
Var
    //m_sTbl : SL3VMETERTAG;
    i : Integer;
Begin
    FsgGrid.ClearNormalCells;
    //FsgGrid.TopRow := 1;
    if m_pDB.GetVParamsTable(m_nMasterIndex,m_sTbl)=True then
    Begin
     for i:=0 to m_sTbl.m_swAmParams-1 do
     AddRecordToGrid(i,@m_sTbl.Item.Items[i]);
    End;
End;
{
m_swID          : Word;
     m_swVMID        : WORD;
     m_swParamID     : WORD;
     m_sParamExpress : String[30];
     m_fValue        : Single;
     m_fMin          : Single;
     m_fMax          : Single;
     m_dtDateTime    : TDateTime;
     m_sblCalculate  : Byte;
     m_sblEnable     : Byte;
    FsgGrid.Cells[0,0]  := '�/T';
    FsgGrid.Cells[1,0]  := 'VMID';
    FsgGrid.Cells[2,0]  := '��������';
    FsgGrid.Cells[3,0]  := '��������   [Do]';
    FsgGrid.Cells[4,0]  := '���������';
    FsgGrid.Cells[5,0]  := '�������� [Post]';
    FsgGrid.Cells[6,0]  := 'Min';
    FsgGrid.Cells[7,0]  := 'Max';
    FsgGrid.Cells[8,0]  := '�����';
    FsgGrid.Cells[9,0]  := '�����������;
    FsgGrid.Cells[10,0]  := '����������';
}
procedure CL3VParamEditor.AddRecordToGrid(nIndex:Integer;pTbl:PSL3PARAMS);
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
     FsgGrid.Cells[2,nY]  := IntToStr(m_swVMID);
     FsgGrid.Cells[3,nY]  := m_nCmdList.Strings[m_swParamID];
     FsgGrid.Cells[4,nY]  := m_sParamExpress;
     //FsgGrid.Cells[5,nY]  := FloatToStrF(m_fValueSv,ffFixed,6,6);
     //FsgGrid.Cells[6,nY]  := FloatToStrF(m_fValue,ffFixed,6,6);
     FsgGrid.Cells[5,nY]  := FloatToStrF(m_fMin,ffFixed,6,6);
     FsgGrid.Cells[6,nY]  := FloatToStrF(m_fLimit,ffFixed,6,6);
     FsgGrid.Cells[7,nY]  := FloatToStrF(m_fMax,ffFixed,6,6);
     FsgGrid.Cells[8,nY]  := FloatToStrF(m_fDiffer,ffFixed,6,6);
     FsgGrid.Cells[9,nY]  := DateTimeToStr(m_dtLastTime);
     //FsgGrid.Cells[8,nY]  := TimeToStr(m_dtLastTime);
     FsgGrid.Cells[10,nY]  := m_nSvPeriodList.Strings[m_stSvPeriod];

     if (m_nTariffList.Count=0)or(m_sblTarif>=m_nTariffList.Count) then
      FsgGrid.Cells[11,nY]:='���� ��� �������' else
     if (m_sblTarif<m_nTariffList.Count) then
      FsgGrid.Cells[11,nY] := m_nTariffList.Strings[m_sblTarif] else FsgGrid.Cells[11,nY]:='���� ��� �������';

     FsgGrid.Cells[12,nY] := m_nEsNoList.Strings[m_sblCalculate];
     FsgGrid.Cells[13,nY] := m_nSaveList.Strings[m_sblSaved];
     FsgGrid.Cells[14,nY] := m_nStatusList.Strings[m_swStatus];
     FsgGrid.Cells[15,nY] := m_nEsNoList.Strings[m_sblEnable];
     FsgGrid.Cells[16,nY] := m_nDataGroup.Strings[m_sbyDataGroup];
     FsgGrid.Cells[17,nY] := m_nEsNoList.Strings[m_sbyLockState];
     FsgGrid.Cells[18,nY] := m_nDataType.Strings[m_snDataType];
    End;
End;
procedure CL3VParamEditor.OnAddAutoVParam;
Begin
    m_pDB.InsertVParams(FTypeIndex,m_nMasterIndex);
    ExecSetGrid;
End;
procedure CL3VParamEditor.OnSetGrid;
Begin
    ExecSetGrid;
End;
procedure CL3VParamEditor.OnSaveGrid;
Var
    i : Integer;
    pTbl:SL3PARAMS;
Begin
    for i:=1 to FsgGrid.RowCount-1 do
    Begin
     if FsgGrid.Cells[1,i]='' then break;
     pTbl.m_swID := i;
     GetGridRecord(pTbl);
    // m_pDB.AddVParamTable(pTbl);
     m_pDB.AddVParamTable(m_nMasterIndex,pTbl);
    End;
    //ExecInitLayer;
    ExecSetGrid;
End;
procedure CL3VParamEditor.GetGridRecord(var pTbl:SL3PARAMS);
Var
    i   : Integer;
    str : String;
Begin
    i := pTbl.m_swID;
    with pTbl do Begin
     m_swID          := StrToInt(FsgGrid.Cells[1,i]);
     m_swVMID        := StrToInt(FsgGrid.Cells[2,i]);
     m_swParamID     := m_nCmdList.IndexOf(FsgGrid.Cells[3,i]);
     m_sParamExpress := FsgGrid.Cells[4,i];
     //m_fValue        := StrToFloat(FsgGrid.Cells[5,i]);
     //m_fValue        := StrToFloat(FsgGrid.Cells[6,i]);
     m_fMin          := StrToFloat(FsgGrid.Cells[5,i]);
     m_fLimit        := StrToFloat(FsgGrid.Cells[6,i]);
     m_fMax          := StrToFloat(FsgGrid.Cells[7,i]);
     m_fDiffer       := StrToFloat(FsgGrid.Cells[8,i]);
     m_dtLastTime    := StrToDateTime(FsgGrid.Cells[9,i]);
     m_stSvPeriod    := m_nSvPeriodList.IndexOf(FsgGrid.Cells[10,i]);
     m_sblTarif      := m_nTariffList.IndexOf(FsgGrid.Cells[11,i]);
     m_sblCalculate  := m_nEsNoList.IndexOf(FsgGrid.Cells[12,i]);
     m_sblSaved      := m_nSaveList.IndexOf(FsgGrid.Cells[13,i]);
     m_swStatus      := m_nStatusList.IndexOf(FsgGrid.Cells[14,i]);
     m_sblEnable     := m_nEsNoList.IndexOf(FsgGrid.Cells[15,i]);
     m_sbyDataGroup  := m_nDataGroup.IndexOf(FsgGrid.Cells[16,i]);
     m_sbyLockState  := m_nEsNoList.IndexOf(FsgGrid.Cells[17,i]);
     m_snDataType    := m_nDataType.IndexOf(FsgGrid.Cells[18,i]);
    End;
End;
procedure CL3VParamEditor.ExecSelRowGrid;
Begin
    FsgGrid.SelectRows(m_nIndex+1,1);
    FsgGrid.Refresh;
    ViewChild(m_nIndex);
End;
procedure CL3VParamEditor.ViewChild(nIndex:Integer);
Begin
    if FChild<>Nil then
    Begin
     FChild.PMasterIndex := nIndex;
     FChild.ExecSetGrid;
    End;
End;
function CL3VParamEditor.FindFreeRow(nIndex:Integer):Integer;
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
procedure CL3VParamEditor.OnAddRow;
Var
    nIndex : Integer;
Begin
    if m_nRowIndex<>-1 then
    Begin
     //SetDefaultRow(m_nRowIndex);
     SetIndex(StrToInt(FsgGrid.Cells[m_nIDIndex,m_nRowIndex]));
    End else
    Begin
     nIndex := FindFreeRow(3);
     //SetDefaultRow(nIndex);
     SetIndex(StrToInt(FsgGrid.Cells[m_nIDIndex,nIndex]));
    End;
End;
procedure CL3VParamEditor.OnCloneRow;
Var
    nIndex : Integer;
    pTbl   : SL3PARAMS;
Begin
    if m_nRowIndex<>-1 then
    if m_nRowIndex<=FindFreeRow(m_nIDIndex)-1 then
    Begin
     pTbl.m_swID   := m_nRowIndex;
     GetGridRecord(pTbl);
     //pTbl.m_swVMID := GenIndexSv;
     AddRecordToGrid(FindFreeRow(m_nIDIndex)-1,@pTbl);
    End;
End;
procedure CL3VParamEditor.OnDelRow;
Var
    nFind : Integer;
Begin
    if m_nAmRecords=FindFreeRow(m_nIDIndex)-1 then
    Begin
     if m_nIndex<>-1 then
     Begin
      ExecDelData;
      //FreeAllIndex;
      //m_pDB.DelPortTable(m_nIndex);
      ExecSetGrid;
      //ViewChild(m_nIndex);
     End;
    End else
    Begin
     if m_nRowIndex<>-1 then
     Begin
      if FsgGrid.Cells[m_nIDIndex,m_nRowIndex]<>'' then
      FreeIndex(StrToInt(FsgGrid.Cells[m_nIDIndex,m_nRowIndex]));
      FsgGrid.ClearRows(m_nRowIndex,1);
      //SetHigthGrid(FsgGrid^,21);
     End;
    End;
End;
procedure CL3VParamEditor.OnDelAllRow;
Begin
    m_pDB.DelVParamTable(m_nMasterIndex,-1);
    FreeAllIndex;
    ExecSetGrid;
End;
procedure CL3VParamEditor.OnClickGrid(Sender: TObject; ARow, ACol: Integer);
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
procedure CL3VParamEditor.OnSetForAllParam;
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
procedure CL3VParamEditor.OnTimeSynchronize;
Begin
    m_pDB.VParamTSynchronize;
    ExecSetGrid;
End;
//Init Layer
procedure CL3VParamEditor.OnInitLayer;
Begin
    //ExecSetTree;
    //ExecInitLayer;
End;
//Index Generator
function  CL3VParamEditor.GenIndex:Integer;
Begin
   Result := -1;
End;
procedure CL3VParamEditor.SetIndex(nIndex : Integer);
Begin
End;
procedure CL3VParamEditor.FreeIndex(nIndex : Integer);
Begin
End;
procedure CL3VParamEditor.FreeAllIndex;
Begin
End;
procedure CL3VParamEditor.OnExecute(Sender: TObject);
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
procedure CL3VParamEditor.OnMDownPE(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
var
blOnClickfrom:boolean;
Begin
    if (Button=mbLeft)and(Shift=[ssCtrl,ssLeft]) then
    Begin
     //m_nMasterIndex,m_nIndex
     blOnClickfrom := false;
     frmEditExpr.m_forAbon    := m_nAbonIndex;
     frmEditExpr.m_forGroup   := m_nGroupIndex;
     frmEditExpr.m_forVMID    := m_nMasterIndex;
     frmEditExpr.m_forParam   := m_nCmdList.IndexOf(FsgGrid.Cells[3,m_nRowIndex]);
     frmEditExpr.m_forCurrExpr:= FsgGrid.Cells[4,m_nRowIndex];
     frmEditExpr.m_forCurrShExpr := m_sTbl.Item.Items[m_nRowIndex-1].m_sParam;
     frmEditExpr.SetParent(FsgGrid,@m_sTbl,blOnClickfrom);
     frmEditExpr.ShowModal;
     if frmEditExpr.m_forRunExpr <> '' then //FsgGrid.Cells[4,m_nRowIndex] := 'Free' else
     FsgGrid.Cells[4,m_nRowIndex] := frmEditExpr.m_forRunExpr;

    End;
End;
//Color And Control
procedure CL3VParamEditor.OnChannelGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
    with (Sender AS TAdvStringGrid)  do Begin
     if (ACol <> 0) and (ARow<>0) and (ARow < RowCount) and
     (not(gdSelected in AState) or (gdFocused in AState)) then
    begin

    // if (ACol<>0)and(ARow<>0) then
   //  ABrush.Color := clTeal;
    
    end;
     if ARow=0 then AFont.Style := [fsBold];
    if (ARow<>0) and (ACol<>0)then
     Begin
      if ACol<>0 then
      Begin
        AFont.Color :=  m_blGridDataFontColor;//clAqua;
        AFont.Size  :=  m_blGridDataFontSize;
        AFont.Name  :=  m_blGridDataFontName;
       if ACol=4 then AFont.Color := clRed;
       //if (ACol and 1)=0  then AFont.Color := clGray;
      End;
     End;
    End;
end;
{
    FsgGrid.Cells[0,0]  := '�/T';
    FsgGrid.Cells[1,0]  := 'ID';
    FsgGrid.Cells[2,0]  := 'VMID';
    FsgGrid.Cells[3,0]  := '��������';
    FsgGrid.Cells[4,0]  := '���������';
    FsgGrid.Cells[5,0]  := '���.L';
    FsgGrid.Cells[6,0]  := '���.L';
    FsgGrid.Cells[7,0]  := '����.';
    FsgGrid.Cells[8,0]  := '�-� ���.';
    FsgGrid.Cells[9,0]  := '���.';
    FsgGrid.Cells[10,0] := '���������';
    FsgGrid.Cells[11,0] := '��� ��.';
    FsgGrid.Cells[12,0] := '��� ���.';
    FsgGrid.Cells[13,0] := '���.';
    FsgGrid.Cells[14,0] := '��� ����.';

}
procedure CL3VParamEditor.OnChannelGetCellType(Sender: TObject; ACol, ARow: Integer;var AEditor: TEditorType);
begin

    with FsgGrid^ do
    case ACol of
     10:Begin
        AEditor := edComboList;
        combobox.items.loadfromfile(m_strCurrentDir+'SavePeriod.dat');
       End;
     11:Begin
        AEditor := edComboList;
        InitComboTariff;
       End;
     13:Begin
        AEditor := edComboList;
        combobox.items.loadfromfile(m_strCurrentDir+'StateSaveParam.dat');
       End;
     14:Begin
        AEditor := edComboList;
        combobox.items.loadfromfile(m_strCurrentDir+'StatParam.dat');
       End;
     12,15,17:Begin
        AEditor := edComboList;
        combobox.items.loadfromfile(m_strCurrentDir+'Active.dat');
       End;
     16:Begin
        AEditor := edComboList;
        combobox.items.loadfromfile(m_strCurrentDir+'DataGroup.dat');
       End;
     18:Begin
        AEditor := edComboList;
        combobox.items.loadfromfile(m_strCurrentDir+'DataType.dat');
       End;
    end;
end;
procedure CL3VParamEditor.OnChandgeComboVL3(ACol, ARow,
               AItemIndex: Integer; ASelection: String);
Begin
    try
    FsgGrid.Cells[2,ARow] := IntToStr(m_sL2Addr[AItemIndex]);
    except
    end;
End;
function CL3VParamEditor.GetComboIndex(cbCombo:TComboBox;str:String):Integer;
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
procedure CL3VParamEditor.SendMSG(byBox,byFor,byType:Byte);
Var
    pMsg : CHMessage;
Begin
    With pMsg do
    Begin
    m_swLen       := 11;
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
procedure CL3VParamEditor.OnSetAllInAbonParam;
Var
    pTable : SL2INITITAG;
    i : Integer;
Begin
i:=m_nAbonIndex;
    if m_pDB.GetMetersIniTable(pTable) then
     for i:=0 to pTable.m_swAmMeter-1 do
     Begin
     // m_sL2Addr[i] := pTable.m_sMeter[i].m_swMID;
    //  FsgGrid.Combobox.Items.Add(pTable.m_sMeter[i].m_schName);
     End;
End;

end.
