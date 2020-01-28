unit knsl2cmdeditor;
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,Messages,
  Graphics, Controls, Forms, Dialogs, Spin,
  Grids, BaseGrid, AdvGrid,utlbox,utlconst,utldatabase,knsl1module,
  knsl2module,knsl2treeloader,knsl5tracer,knsl5config;
type
    CL2CmdEditor = class
    Private
     FTreeModule    : PTTreeView;
     m_byTrState    : Byte;
     m_byTrEditMode : Byte;
     m_nAmRecords   : Integer;
     m_nRowIndex    : Integer;
     m_nColIndex    : Integer;
     m_nPageIndex   : Integer;
     m_nIndex       : Integer;
     m_nMasterIndex : Integer;
     FTypeIndex     : Integer;
     m_strCurrentDir: String;
     m_nTypeList    : TStringList;
     FsgGrid        : PTAdvStringGrid;
     FcbCmdCombo    : PTComboBox;
     FTreeLoader    : PCTreeLoader;
     m_nParams      : QM_PARAMS;
     FFaddres       : Integer;
     FPortID        : Integer;
     m_nTehnoLen    : Integer;
     FAbonID        : Integer;
     constructor Create;
     procedure InitCombo;
     procedure OnExecute(Sender: TObject);
     procedure ExecEditData;
     procedure ExecAddData;
     procedure ExecDelData;

     procedure AddRecordToGrid(nIndex:Integer;pTbl:PCCOMMAND);
     procedure SetIndex(nIndex : Integer);
     function  GenIndex:Integer;
     procedure FreeIndex(nIndex : Integer);
     function  FindFreeRow(nIndex:Integer):Integer;
     procedure GetGridRecord(var pTbl:CCOMMAND);
     function  GetComboIndex(cbCombo:TComboBox;str:String):Integer;
     procedure SetDefaultRow(i:Integer);
     function  GetEcomChannel(nCMD:Integer):String;
    Public
     procedure Init;
     destructor Destroy; override;
     procedure ExecSelRowGrid;
     procedure OnFormResize;
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
     procedure OnDelRow;
     procedure OnDelAllRow;
     procedure OnExecInit;
     procedure OnAddAutoCmd;
     procedure OnChannelGen;
     procedure OnTypeSet;
     procedure SetEdit;
     procedure OnSetCmdForMeters;
     procedure OnSetCmdForPMeters;
     procedure OnSetCmdForMeter;
     procedure OpenInfo;
     procedure CloseInfo;
     procedure ADDChanel_164M(AbonID:integer);
    Public
     property PTreeModule :PTTreeView      read FTreeModule    write FTreeModule;
     property PsgGrid     :PTAdvStringGrid read FsgGrid        write FsgGrid;
     property PcbCmdCombo :PTComboBox      read FcbCmdCombo    write FcbCmdCombo;
     property PPageIndex  :Integer         read m_nPageIndex   write m_nPageIndex;
     property PIndex      :Integer         read m_nIndex       write m_nIndex;
     property PMasterIndex:Integer         read m_nMasterIndex write m_nMasterIndex;
     property PFaddres    :Integer         read FFaddres       write FFaddres;
     property PTypeIndex  :Integer         read FTypeIndex     write FTypeIndex;
     property PPortID     :Integer         read FPortID        write FPortID;
     property PTreeLoader :PCTreeLoader    read FTreeLoader    write FTreeLoader;
     property PAbonID     :Integer         read FAbonID        write FAbonID;
    End;
implementation
constructor CL2CmdEditor.Create;
Begin

End;
//ExtractFilePath(Application.ExeName)
{
   CCOMMAND = packed record
     m_swID       : Word;
     m_swMID      : Word;
     m_swCmdID    : Word;
     m_swSpecc0   : Word;
     m_swSpecc1   : Word;
     m_swSpecc2   : Word;
     m_sbyEnable  : Byte;
    End;
}

destructor CL2CmdEditor.Destroy;
begin
  if m_nTypeList <> nil then FreeAndNil(m_nTypeList);
  inherited;
end;

procedure CL2CmdEditor.Init;
Var
    i : Integer;
Begin
    m_strCurrentDir := ExtractFilePath(Application.ExeName) + '\\Settings\\';
    m_nTypeList := TStringList.Create;
    m_nTypeList.loadfromfile(m_strCurrentDir+'CommandType.dat');
    //FTreeModule.Color       := KNS_COLOR;
    m_nRowIndex := -1;
    m_nColIndex := -1;
    FTypeIndex  := -1;
    FsgGrid.Color       := KNS_NCOLOR;
    FsgGrid.ColCount    := 10;
    FsgGrid.RowCount    := 100;
    FsgGrid.Cells[0,0]  := '№/T';
    FsgGrid.Cells[1,0]  := 'ID';
    FsgGrid.Cells[2,0]  := 'MtrID';
    FsgGrid.Cells[3,0]  := 'CmdID';
    //FsgGrid.Cells[4,0]  := 'Выражение';
    FsgGrid.Cells[4,0]  := 'Спецификация №1';
    FsgGrid.Cells[5,0]  := 'Спецификация №2';
    FsgGrid.Cells[6,0]  := 'Спецификация №3';
    FsgGrid.Cells[7,0]  := 'Активность';
    FsgGrid.Cells[8,0]  := '№ измерения';
    FsgGrid.Cells[9,0]  := 'Тип данных';
    FsgGrid.ColWidths[0]:= 30;
    FsgGrid.ColWidths[1]:= 0;
    FsgGrid.ColWidths[2]:= 0;
    FsgGrid.ColWidths[3]:= 270;
    m_nTehnoLen := 270;
    //InitCombo;
    //ExecSetTree;
    //ExpandTree(FTreeModule^,'Каналы');
    //ExecSetGrid;
End;
procedure CL2CmdEditor.OpenInfo;
Begin
    FsgGrid.ColWidths[0]:= 30;
    FsgGrid.ColWidths[1]:= 40;
    FsgGrid.ColWidths[2]:= 40;
    FsgGrid.ColWidths[3]:= 270;
    m_nTehnoLen := 80+270;
    OnFormResize;
End;
procedure CL2CmdEditor.CloseInfo;
Begin
    FsgGrid.ColWidths[0]:= 30;
    FsgGrid.ColWidths[1]:= 0;
    FsgGrid.ColWidths[2]:= 0;
    FsgGrid.ColWidths[3]:= 270;
    m_nTehnoLen := 270;
    OnFormResize;
End;


procedure CL2CmdEditor.OnFormResize;
Var
    i : Integer;
Begin
    for i:=4 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-(m_nTehnoLen)-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1-3));
End;
procedure CL2CmdEditor.SetEdit;
begin
    m_nRowIndex := -1;
end;
//Edit Add Del Request
procedure CL2CmdEditor.OnEditNode;
begin
end;
procedure CL2CmdEditor.OnAddNode;
begin
end;
procedure CL2CmdEditor.OnDeleteNode;
Begin
End;
//Edit Add Del Execute
procedure CL2CmdEditor.ExecSetEditData(nIndex:Integer);
Begin
    TraceL(1,0,'ExecSetEditData.');
End;
procedure CL2CmdEditor.ExecEditData;
Begin
    TraceL(1,0,'ExecEditData.');
End;
procedure CL2CmdEditor.ExecAddData;
Begin
    TraceL(1,0,'ExecAddData.');
End;
procedure CL2CmdEditor.ExecDelData;
Begin
    TraceL(1,0,'ExecDelData.');
End;
procedure CL2CmdEditor.ExecInitLayer;
Begin
    TraceL(1,0,'ExecInitLayer.');
    mL2Module.Init;
End;
//Tree Reload
procedure CL2CmdEditor.ExecSetTree;
Begin
    TraceL(1,0,'ExecSetTree.');
    FTreeLoader.LoadTree;
End;
procedure CL2CmdEditor.OnSetCmdForMeters;
Var
    m_wMID,m_swCmdID,m_sbyEnable : Integer;
Begin
    if m_nRowIndex<>-1 then
    Begin
     m_swCmdID   := m_nTypeList.IndexOf(FsgGrid.Cells[3,m_nRowIndex]);
     m_sbyEnable := m_nEsNoList.IndexOf(FsgGrid.Cells[7,m_nRowIndex]);
     m_pDB.OpenCommand(m_swCmdID,m_sbyEnable);
    End;
End;
{
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
 FsgGrid.Cells[4,0]  := 'Спецификация №1';
    FsgGrid.Cells[5,0]  := 'Спецификация №2';
    FsgGrid.Cells[6,0]  := 'Спецификация №3';
    FsgGrid.Cells[7,0]  := 'Активность';
    FsgGrid.Cells[8,0]  := '№ измерения';
    FsgGrid.Cells[9,0]  := 'Тип данных';
  FsgGrid.Cells[4,nY] := IntToStr(m_swSpecc0);
     FsgGrid.Cells[5,nY] := IntToStr(m_swSpecc1);
     FsgGrid.Cells[6,nY] := IntToStr(m_swSpecc2);
     FsgGrid.Cells[7,nY] := m_nEsNoList.Strings[m_sbyEnable];
     FsgGrid.Cells[8,nY] := m_swChannel;
     FsgGrid.Cells[9,nY] := m_nDataType.Strings[m_snDataType];
}
procedure CL2CmdEditor.OnSetCmdForMeter;
Var
    m_wMID,m_swCmdID,m_sbyEnable : Integer;
    strCmd : String;
Begin
    if (m_nColIndex=-1)or(m_nRowIndex=-1) then exit;
    if m_nColIndex=4 then strCmd := 'm_swSpecc0='+FsgGrid.Cells[m_nColIndex,m_nRowIndex];
    if m_nColIndex=5 then strCmd := 'm_swSpecc1='+FsgGrid.Cells[m_nColIndex,m_nRowIndex];
    if m_nColIndex=6 then strCmd := 'm_swSpecc2='+FsgGrid.Cells[m_nColIndex,m_nRowIndex];
    if m_nColIndex=7 then strCmd := 'm_sbyEnable='+IntToStr(m_nEsNoList.IndexOf(FsgGrid.Cells[m_nColIndex,m_nRowIndex]));
    if m_nColIndex=8 then strCmd := 'm_swChannel='+''''+FsgGrid.Cells[m_nColIndex,m_nRowIndex]+'''';
    if m_nColIndex=9 then strCmd := 'm_snDataType='+IntToStr(m_nDataType.IndexOf(FsgGrid.Cells[m_nColIndex,m_nRowIndex]));
    m_swCmdID   := m_nTypeList.IndexOf(FsgGrid.Cells[3,m_nRowIndex]);
    m_pDB.OpenPortCommandStr(strCmd,m_swCmdID,FPortID);
End;
procedure CL2CmdEditor.OnSetCmdForPMeters;
Begin

End;
//Grid Routine
procedure CL2CmdEditor.ExecSetGrid;
Var
    pTbl : CCOMMANDS;
    i : Integer;
Begin
    FsgGrid.ClearNormalCells;
    //FsgGrid.TopRow := 1;
    //FreeAllIndex;
    if m_pDB.GetCommandsTable(m_nMasterIndex,pTbl)=True then
    Begin
     m_nAmRecords := pTbl.m_swAmCommand;
     for i:=0 to pTbl.m_swAmCommand-1 do
     AddRecordToGrid(i,@pTbl.m_sCommand[i]);
    End;
End;
procedure CL2CmdEditor.AddRecordToGrid(nIndex:Integer;pTbl:PCCOMMAND);
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
     FsgGrid.Cells[2,nY] := IntToStr(m_swMID);
     FsgGrid.Cells[3,nY] := m_nTypeList.Strings[m_swCmdID];
     //FsgGrid.Cells[4,nY] := m_sExpress;
     FsgGrid.Cells[4,nY] := IntToStr(m_swSpecc0);
     FsgGrid.Cells[5,nY] := IntToStr(m_swSpecc1);
     FsgGrid.Cells[6,nY] := IntToStr(m_swSpecc2);
     FsgGrid.Cells[7,nY] := m_nEsNoList.Strings[m_sbyEnable];
     FsgGrid.Cells[8,nY] := m_swChannel;
     FsgGrid.Cells[9,nY] := m_nDataType.Strings[m_snDataType];
    End;
End;
procedure CL2CmdEditor.OnSetGrid;
Begin
    ExecSetGrid;
End;
procedure CL2CmdEditor.OnSaveGrid;
Var
    i : Integer;
    pTbl:CCOMMAND;
Begin
    for i:=1 to 70 do
    Begin
     if FsgGrid.Cells[3,i]='' then break;
     pTbl.m_swID := i;
     GetGridRecord(pTbl);
     m_pDB.AddCommandTable(pTbl);
    End;
    mL2Module.InitScenario(m_nMasterIndex);
    ExecSetGrid;
End;
{
CCOMMAND = packed record
     m_swID       : Word;
     m_swMID      : Word;
     m_swCmdID    : Word;
     m_swSpecc0   : Word;
     m_swSpecc1   : Word;
     m_swSpecc2   : Word;
     m_sbyEnable  : Byte;
    End;
}
procedure CL2CmdEditor.GetGridRecord(var pTbl:CCOMMAND);
Var
    i : Integer;
    str : String;
Begin
    i := pTbl.m_swID;
    with pTbl do Begin
     SetDefaultRow(i);
     m_swID      := StrToInt(FsgGrid.Cells[1,i]);
     m_swMID     := StrToInt(FsgGrid.Cells[2,i]);
     m_swCmdID   := m_nTypeList.IndexOf(FsgGrid.Cells[3,i]);
     //m_sExpress  := FsgGrid.Cells[4,i];
     m_swSpecc0  := StrToInt(FsgGrid.Cells[4,i]);
     m_swSpecc1  := StrToInt(FsgGrid.Cells[5,i]);
     m_swSpecc2  := StrToInt(FsgGrid.Cells[6,i]);
     m_sbyEnable := m_nEsNoList.IndexOf(FsgGrid.Cells[7,i]);
     m_swChannel := FsgGrid.Cells[8,i];
     m_snDataType:= m_nDataType.IndexOf(FsgGrid.Cells[9,i]);
     //str         := FsgGrid.Cells[8,i];
     //m_sbyEnable := GetComboIndex(frmEditNode.m_sbyEnable,str);
    End;
End;
procedure CL2CmdEditor.SetDefaultRow(i:Integer);
Begin
     if FsgGrid.Cells[1,i]='' then FsgGrid.Cells[1,i] := '-1';
     if FsgGrid.Cells[2,i]='' then FsgGrid.Cells[2,i] := IntToStr(m_nMasterIndex);
     if FsgGrid.Cells[3,i]='' then FsgGrid.Cells[3,i] := 'QRY_ENERGY_SUM_EP';
     //if FsgGrid.Cells[4,i]='' then FsgGrid.Cells[4,i] := '';
     if FsgGrid.Cells[4,i]='' then FsgGrid.Cells[4,i] := '0';
     if FsgGrid.Cells[5,i]='' then FsgGrid.Cells[5,i] := '0';
     if FsgGrid.Cells[6,i]='' then FsgGrid.Cells[6,i] := '0';
     if FsgGrid.Cells[7,i]='' then FsgGrid.Cells[7,i] := m_nEsNoList.Strings[1];
     if FsgGrid.Cells[8,i]='' then FsgGrid.Cells[8,i] := '0';
     if FsgGrid.Cells[9,i]='' then FsgGrid.Cells[9,i] := m_nDataType.Strings[DTP_DBL5];
End;
procedure CL2CmdEditor.ExecSelRowGrid;
Begin
    FsgGrid.SelectRows(m_nIndex+1,1);
    FsgGrid.Refresh;
    //ViewChild(m_nIndex);
End;
function CL2CmdEditor.FindFreeRow(nIndex:Integer):Integer;
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
procedure CL2CmdEditor.OnClickGrid(Sender: TObject; ARow, ACol: Integer);
Begin
    m_nRowIndex := -1;
    m_nColIndex := -1;
    if ARow>0 then Begin
     if FsgGrid.Cells[1,ARow]<>'' then
     Begin
      m_nIndex := StrToInt(FsgGrid.Cells[1,ARow]);
      //ViewChild(m_nIndex);
     End else m_nIndex := -1;
     m_nRowIndex := ARow;
     m_nColIndex := ACol;
    End;
End;
procedure CL2CmdEditor.OnDelRow;
Var
    nFind : Integer;
Begin
    if m_nAmRecords=FindFreeRow(1)-1 then
    Begin
     if m_nIndex<>-1 then
     Begin
      ExecDelData;
      m_pDB.DelCommandTable(m_nMasterIndex,m_nIndex);
      ExecSetGrid;
     End;
    End else
    Begin
     if m_nRowIndex<>-1 then
     Begin
      if FsgGrid.Cells[1,m_nRowIndex]<>'' then
      FreeIndex(StrToInt(FsgGrid.Cells[1,m_nRowIndex]));
      FsgGrid.ClearRows(m_nRowIndex,1);
     End;
    End;
End;
procedure CL2CmdEditor.OnDelAllRow;
Begin
    m_pDB.DelCommandTable(m_nMasterIndex,-1);
    ExecSetGrid;
End;
procedure CL2CmdEditor.OnAddAutoCmd;
Begin
    if FTypeIndex<>-1 then
    Begin
     m_pDB.LoadCommand(m_nMasterIndex,FTypeIndex);
     ExecSetGrid;
    End;
End;
procedure CL2CmdEditor.OnChannelGen;
Var
    pTbl : CCOMMANDS;
    i   : Integer;
Begin
    if (FTypeIndex=MET_EKOM3000)or(FTypeIndex=MET_SUMM) then
    Begin
     if m_pDB.GetCommandsTable(m_nMasterIndex,pTbl)=True then
     Begin
      for i:=0 to pTbl.m_swAmCommand-1 do
      FsgGrid.Cells[8,i+1] := GetEcomChannel(pTbl.m_sCommand[i].m_swCmdID);
     End;
    End;
End;
procedure CL2CmdEditor.OnTypeSet;
Var
    pTbl : QM_COMMANDS;
    i   : Integer;
Begin
    if m_pDB.GetQMCmdDirTable(FTypeIndex,m_nMasterIndex,pTbl)=True then
    Begin
     for i:=0 to pTbl.m_swAmCommandType-1 do
     FsgGrid.Cells[9,i+1] :=  m_nDataType.Strings[pTbl.m_sCommandType[i].m_snDataType];
    End;
    //ExecSetGrid;
End;
function CL2CmdEditor.GetEcomChannel(nCMD:Integer):String;
Var
    nBS : String;
Begin
    nBS := 'B';
    if FTypeIndex=MET_SUMM then nBS := 'S';
    //Накопительные
    if (nCMD>=QRY_SRES_ENR_EP)and(nCMD<=QRY_SRES_ENR_RM)        then Result := nBS+IntToStr(4*FFAddres+(4-(QRY_SRES_ENR_RM-nCMD)));
    if (nCMD>=QRY_NAK_EN_DAY_EP)and(nCMD<=QRY_NAK_EN_DAY_RM)    then Result := nBS+IntToStr(4*FFAddres+(4-(QRY_NAK_EN_DAY_RM-nCMD)));
    if (nCMD>=QRY_NAK_EN_MONTH_EP)and(nCMD<=QRY_NAK_EN_MONTH_RM)then Result := nBS+IntToStr(4*FFAddres+(4-(QRY_NAK_EN_MONTH_RM-nCMD)));
    if (nCMD>=QRY_ENERGY_DAY_EP)and(nCMD<=QRY_ENERGY_DAY_RM)    then Result := nBS+IntToStr(4*FFAddres+(4-(QRY_ENERGY_DAY_RM-nCMD)));
    if (nCMD>=QRY_ENERGY_MON_EP)and(nCMD<=QRY_ENERGY_MON_RM)    then Result := nBS+IntToStr(4*FFAddres+(4-(QRY_ENERGY_MON_RM-nCMD)));
    {//Мгновенные
    if (nCMD=QRY_FREQ_NET)                                      then Result := 'G'+IntToStr(15*FFAddres+(1-(QRY_FREQ_NET-nCMD)));
    if (nCMD>=QRY_U_PARAM_A)and(nCMD<=QRY_U_PARAM_C)            then Result := 'G'+IntToStr(15*FFAddres+(1+3-(QRY_U_PARAM_C-nCMD)));
    if (nCMD>=QRY_I_PARAM_A)and(nCMD<=QRY_I_PARAM_C)            then Result := 'G'+IntToStr(15*FFAddres+(1+3+3-(QRY_I_PARAM_C-nCMD)));
    if (nCMD>=QRY_MGAKT_POW_S)and(nCMD<=QRY_MGAKT_POW_C)        then Result := 'G'+IntToStr(15*FFAddres+(1+3+3+4-(QRY_MGAKT_POW_C-nCMD)));
    if (nCMD>=QRY_MGREA_POW_S)and(nCMD<=QRY_MGREA_POW_C)        then Result := 'G'+IntToStr(15*FFAddres+(1+3+3+4+4-(QRY_MGREA_POW_C-nCMD)));
    //Журналы сбытий
    //if (nCMD=QRY_JRNL_T1)                                       then Result := 'J0';
    /if (nCMD=QRY_JRNL_T3)                                       then Result := 'J'+IntToStr(FFAddres + 1);
    }
    // С QRY_KOEF_POW_A
    if (nCMD=QRY_FREQ_NET)                                      then Result := 'G'+IntToStr(18*FFAddres+(1-(QRY_FREQ_NET-nCMD)));
    if (nCMD>=QRY_U_PARAM_A)and(nCMD<=QRY_U_PARAM_C)            then Result := 'G'+IntToStr(18*FFAddres+(1+3-(QRY_U_PARAM_C-nCMD)));
    if (nCMD>=QRY_I_PARAM_A)and(nCMD<=QRY_I_PARAM_C)            then Result := 'G'+IntToStr(18*FFAddres+(1+3+3-(QRY_I_PARAM_C-nCMD)));
    if (nCMD>=QRY_MGAKT_POW_S)and(nCMD<=QRY_MGAKT_POW_C)        then Result := 'G'+IntToStr(18*FFAddres+(1+3+3+4-(QRY_MGAKT_POW_C-nCMD)));
    if (nCMD>=QRY_MGREA_POW_S)and(nCMD<=QRY_MGREA_POW_C)        then Result := 'G'+IntToStr(18*FFAddres+(1+3+3+4+4-(QRY_MGREA_POW_C-nCMD)));
    if (nCMD>=QRY_KOEF_POW_A)and(nCMD<=QRY_KOEF_POW_C)          then Result := 'G'+IntToStr(18*FFAddres+(1+3+3+4+4+3-(QRY_KOEF_POW_C-nCMD)));
    //Журналы сбытий
    if (nCMD=QRY_JRNL_T1)                                       then Result := 'J0';
    if (nCMD=QRY_JRNL_T3)                                       then Result := 'J'+IntToStr(FFAddres + 1);
End;
//Init Layer
procedure CL2CmdEditor.OnExecInit;
Begin
    //ExecSetTree;
    ExecInitLayer;
End;
//Index Generator
function  CL2CmdEditor.GenIndex:Integer;
Var
    i : Integer;
Begin
    for i:=0 to MAX_METER do
    if m_blMeterIndex[i]=True then
    Begin
     Result := i;
     exit;
    End;
    Result := -1;
End;
Procedure CL2CmdEditor.SetIndex(nIndex : Integer);
Begin
End;
Procedure CL2CmdEditor.FreeIndex(nIndex : Integer);
Begin
End;
procedure CL2CmdEditor.OnExecute(Sender: TObject);
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
procedure CL2CmdEditor.OnChannelGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
    OnGlGetCellColor(Sender,ARow,ACol,AState,ABrush,AFont);
end;
procedure CL2CmdEditor.InitCombo;
Var
    pTable : QM_COMMANDS;
    i : Integer;
Begin
    if m_pDB.GetQMCommandsTable(-1,pTable) then
    Begin
     if FsgGrid<>Nil then FsgGrid.Combobox.Items.Clear;
     m_nTypeList.Clear;
     for i:=0 to pTable.m_swAmCommandType -1 do
     Begin
      if FsgGrid<>Nil then FsgGrid.Combobox.Items.Add(pTable.m_sCommandType[i].m_sName);
      m_nTypeList.Add(pTable.m_sCommandType[i].m_sName);
     End;
    End;
End;
{
procedure CL2CmdEditor.InitCombo;
Var
    i : Integer;
Begin
    if m_pDB.GetParamsTypeTable(m_nParams) then
    Begin
     FsgGrid.combobox.ItemHeight := 30;
     FsgGrid.combobox.Items.Clear;
     for i:=0 to m_nParams.m_swAmParamType-1 do
     FsgGrid.combobox.Items.Add(m_nParams.m_sParamType[i].m_sName);
    End;
End;
}
procedure CL2CmdEditor.OnChannelGetCellType(Sender: TObject; ACol, ARow: Integer;var AEditor: TEditorType);
begin
    with FsgGrid^ do
    case ACol of
     3:Begin
        AEditor := edComboList;
        combobox.items.loadfromfile(m_strCurrentDir+'CommandType.dat');
        //InitCombo;
       End;
     7:Begin
        AEditor := edComboList;
        combobox.items.loadfromfile(m_strCurrentDir+'Active.dat');
       End;
     9:Begin
        AEditor := edComboList;
        combobox.items.loadfromfile(m_strCurrentDir+'DataType.dat');
       End;
    end;
end;
function CL2CmdEditor.GetComboIndex(cbCombo:TComboBox;str:String):Integer;
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

procedure CL2CmdEditor.ADDChanel_164M(AbonID:integer);
var
pTable:SL2INITITAG;
pTableCcommand:CCOMMANDS;
i,j:integer;
begin
     m_pDB.GetMetersTable(AbonID,pTable);
     for i:=0 to pTable.m_swAmMeter-1 do
     if m_pDB.GetCommandsTable(pTable.m_sMeter[i].m_swMID,pTableCcommand)=True then
       for j:=0 to pTableCcommand.m_swAmCommand-1 do
         if (m_nRowIndex=j) then
         begin
            if pTableCcommand.m_sCommand[j-1].m_swCmdID=QRY_NAK_EN_MONTH_EP then pTableCcommand.m_sCommand[j-1].m_swChannel:=FsgGrid.Cells[m_nColIndex,m_nRowIndex]+IntToStr(StrToInt(pTable.m_sMeter[i].m_sddPHAddres)-1)+';';//'F0;0;'+ IntToStr(StrToInt(pTable.m_sMeter[i].m_sddPHAddres)-1);//
            if pTableCcommand.m_sCommand[j-1].m_swCmdID=QRY_NAK_EN_DAY_EP then pTableCcommand.m_sCommand[j-1].m_swChannel:=FsgGrid.Cells[m_nColIndex,m_nRowIndex]+IntToStr(StrToInt(pTable.m_sMeter[i].m_sddPHAddres)-1)+';';//'F0;2;'+ IntToStr(StrToInt(pTable.m_sMeter[i].m_sddPHAddres)-1);
           m_pDB.SetCommandTable(pTableCcommand.m_sCommand[j-1]);
         end;
end;

end.
