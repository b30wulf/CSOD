unit knsl2editor;
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,Messages,
  Graphics, Controls, Forms, Dialogs, Spin,
  Grids, BaseGrid, AdvGrid,utlbox,utlconst,utldatabase,knsl1module,
  knsl2module,knsl2cmdeditor,knsl2treeloader,knsl5tracer,knsl5config,utlTimeDate,knsl5MainEditor;
type
    CL2Editor = class
    Private
     FTreeModule    : PTTreeView;
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
     m_nTehnoLen    : Integer;
   public
     m_nTypeList    : TStringList;
   private
     FsgGrid        : PTAdvStringGrid;
     FChild         : CL2CmdEditor;
     FTreeLoader    : PCTreeLoader;
     constructor Create;
     function  FindRow(str:String):Integer;
     procedure ViewDefault;
     procedure ViewChild(nIndex:Integer);
     procedure OnExecute(Sender: TObject);
     procedure ExecEditData;
     procedure ExecAddData;
     procedure ExecDelData;

     procedure AddRecordToGrid(nIndex:Integer;pTbl:PSL2TAG);
     function  FindFreeRow(nIndex:Integer):Integer;
     procedure SetDefaultRow(i:Integer);
     procedure GetGridRecord(var pTbl:SL2TAG);
     function  GetComboIndex(cbCombo:TComboBox;str:String):Integer;
     procedure SendMSG(byBox,byFor,byType:Byte);
     procedure InitCombo;
    Public
     procedure Init;
     destructor Destroy; override;
     procedure mnAutoUnLockClick;
     procedure mnAutoLockClick;
     procedure SendL3Event(byType:Byte;byJrnType:Byte;wEvType:Word;nMID:Word;nPrm:Double;dtDate:TDateTime);
     procedure ExecSelRowGrid;
     procedure OnFormResize;
     procedure OnSetForAll;
     procedure OnChannelGetCellColor(Sender: TObject; ARow,
               ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
     procedure OnChannelGetCellType(Sender: TObject; ACol,
               ARow: Integer; var AEditor: TEditorType);
     procedure OnClickGrid(Sender: TObject; ARow, ACol: Integer);
     procedure OnClickGridAbonId(Sender: TObject; ARow, ACol: Integer;var AbonId:Integer);
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
     procedure ExecMainEditor;
     procedure OnSaveGridAdr(sNum,sAdres:string);
     function  GetParceString(nID:Integer;sAdvDiscL2Tag,sAdres:String):String;
     procedure OpenInfo;
     procedure CloseInfo;
    Public
     property PTreeModule :PTTreeView       read FTreeModule    write FTreeModule;
     property PsgGrid     :PTAdvStringGrid  read FsgGrid        write FsgGrid;
     property PPageIndex  :Integer          read m_nPageIndex   write m_nPageIndex;
     property PIndex      :Integer          read m_nIndex       write m_nIndex;
     property PMasterIndex:Integer          read m_nMasterIndex write m_nMasterIndex;
     property PChild      :CL2CmdEditor     read FChild         write FChild;
     property PTreeLoader :PCTreeLoader     read FTreeLoader    write FTreeLoader;
    End;
implementation
constructor CL2Editor.Create;
Begin

End;
//ExtractFilePath(Application.ExeName)
{
     m_sbyGroupID     : Byte;
     m_swPoint      : WORD;
     m_sbyPortID    : Byte;
     m_swMID        : WORD;

     m_sbyType      : Byte;
     m_sddPHAddres  : string[26];
     m_schPassword  : String[16];
     m_schName      : String[30];

     //m_sbyPortTypeID: Byte;
     m_sbyRepMsg    : Byte;
     m_swRepTime    : Word;
     m_swCurrQryTm  : Word;
     m_swGraphQryTm : Word;
     m_sfKI         : single;
     m_sfKU         : single;
     m_sfMeterKoeff : single;
     m_sbyHandScenr : Byte;
     m_sbyEnable    : Byte;
}

destructor CL2Editor.Destroy;
begin
  if FChild <> nil then FreeAndNil(FChild);
  if m_nTypeList <> nil then FreeAndNil(m_nTypeList);

  inherited;
end;

procedure CL2Editor.Init;
Var
    i : Integer;
Begin
    m_strCurrentDir := ExtractFilePath(Application.ExeName) + '\\Settings\\';
    for i:=0 to MAX_METER do m_blMeterIndex[i] := True;
    //FTreeModule.Color     := KNS_COLOR;
    m_nTypeList := TStringList.Create;

    {
    m_sbyLocation,m_sddFabNum
    }

    m_nRowIndex   := -1;
    m_nRowIndexEx := 1;
    m_nIDIndex    := 4;
    m_nColIndex   := 1;
    FsgGrid.Color       := KNS_NCOLOR;
    FsgGrid.ColCount    := 53;
    FsgGrid.RowCount    := 1000;
    FsgGrid.Cells[0,0]  := '№/T';
    FsgGrid.Cells[1,0]  := 'Пулл';
    FsgGrid.Cells[2,0]  := 'VMID';

    FsgGrid.Cells[3,0]  := 'Abon';
    FsgGrid.Cells[4,0]  := 'MID';

    FsgGrid.Cells[5,0]  := 'Тип';
    FsgGrid.Cells[6,0]  := 'Расположение';
    FsgGrid.Cells[7,0]  := 'Зав.Номер';

    FsgGrid.Cells[8,0]  := 'Физ.Адр.';
    FsgGrid.Cells[9,0]  := 'Пароль';
    FsgGrid.Cells[10,0] := 'Название';

    FsgGrid.Cells[11,0] := 'К-во повт.';
    FsgGrid.Cells[12,0] := 'П-д.повт';
    FsgGrid.Cells[13,0] := 'KI';
    FsgGrid.Cells[14,0] := 'KU';
    FsgGrid.Cells[15,0] := 'KM';

    FsgGrid.Cells[16,0] := 'Cум. кор.';
    FsgGrid.Cells[17,0] := 'Пр. кор.';
    FsgGrid.Cells[18,0] := 'Физ. пр.';

    FsgGrid.Cells[19,0] := 'К-во зн-в';

    FsgGrid.Cells[20,0] := 'Период';

    FsgGrid.Cells[21,0] := 'Т.срез';
    FsgGrid.Cells[22,0] := 'Тел.';
    FsgGrid.Cells[23,0] := 'Модем';

    FsgGrid.Cells[24,0] := 'Активн.';
    FsgGrid.Cells[25,0] := 'Доп. пар.';
    FsgGrid.Cells[26,0] := 'Сост. бл.';
    FsgGrid.Cells[27,0] := 'Тар.';

    FsgGrid.ColWidths[0]:= 30;
    FsgGrid.ColWidths[1]:= 30;
    FsgGrid.ColWidths[2]:= 0;
    FsgGrid.ColWidths[3]:= 0;
    FsgGrid.ColWidths[4]:= 0;

    FsgGrid.ColWidths[5]:= 60;
    FsgGrid.ColWidths[6]:= 60;
    FsgGrid.ColWidths[7]:= 60;
    FsgGrid.ColWidths[8]:= 60;
    FsgGrid.ColWidths[9]:= 60;
    FsgGrid.ColWidths[10]:= 150;
    FsgGrid.ColWidths[25]:= 0;
    FsgGrid.ColWidths[26]:= 0;
    FsgGrid.ColWidths[27]:= 0;
    FsgGrid.ColWidths[28]:= 0;
    FsgGrid.ColWidths[29]:= 0;

    for i:=25 to FsgGrid.ColCount-1 do FsgGrid.ColWidths[i]:= 0;
    m_nTehnoLen := 480;

    FChild             := CL2CmdEditor.Create;
    FChild.PPageIndex  := 2;
    InitCombo;
    
End;
procedure CL2Editor.OpenInfo;
Var
    i : Integer;
Begin
    FsgGrid.ColWidths[0]:= 30;
    FsgGrid.ColWidths[1]:= 30;
    FsgGrid.ColWidths[2]:= 0;
    FsgGrid.ColWidths[3]:= 35;
    FsgGrid.ColWidths[4]:= 35;

    FsgGrid.ColWidths[5]:= 60;
    FsgGrid.ColWidths[6]:= 60;
    FsgGrid.ColWidths[7]:= 60;
    FsgGrid.ColWidths[8]:= 60;
    FsgGrid.ColWidths[9]:= 60;
    FsgGrid.ColWidths[10]:= 150;
    FsgGrid.ColWidths[25]:= 0;
    FsgGrid.ColWidths[26]:= 0;
    FsgGrid.ColWidths[27]:= 0;
    FsgGrid.ColWidths[28]:= 0;
    FsgGrid.ColWidths[29]:= 0;
    for i:=25 to FsgGrid.ColCount-1 do FsgGrid.ColWidths[i]:= 0;
    m_nTehnoLen := 70+480;
    OnFormResize;
End;
procedure CL2Editor.CloseInfo;
Var
    i : Integer;
Begin
    FsgGrid.ColWidths[0]:= 30;
    FsgGrid.ColWidths[1]:= 30;
    FsgGrid.ColWidths[2]:= 0;
    FsgGrid.ColWidths[3]:= 0;
    FsgGrid.ColWidths[4]:= 0;

    FsgGrid.ColWidths[5]:= 60;
    FsgGrid.ColWidths[6]:= 60;
    FsgGrid.ColWidths[7]:= 60;
    FsgGrid.ColWidths[8]:= 60;
    FsgGrid.ColWidths[9]:= 60;
    FsgGrid.ColWidths[10]:= 150;
    FsgGrid.ColWidths[25]:= 0;
    FsgGrid.ColWidths[26]:= 0;
    FsgGrid.ColWidths[27]:= 0;
    FsgGrid.ColWidths[28]:= 0;
    FsgGrid.ColWidths[29]:= 0;
    for i:=25 to FsgGrid.ColCount-1 do FsgGrid.ColWidths[i]:= 0;
    m_nTehnoLen := 480;
    OnFormResize;
End;
procedure CL2Editor.OnFormResize;
Var
    i : Integer;
Begin
    for i:=11 to 24  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-(m_nTehnoLen)-2*FsgGrid.ColWidths[0])/(14));
    PChild.OnFormResize;
End;
procedure CL2Editor.SetEdit;
Var
    pTbl : SL2INITITAG;
    i    : Integer;
Begin
    m_nRowIndex := -1;
    //FreeAllIndex;
    //if m_pDB.GetMetersTable(m_nMasterIndex,pTbl)=True then for i:=0 to pTbl.m_swAmMeter-1 do SetIndex(pTbl.m_sMeter[i].m_swMID);
    //if m_pDB.GetMetersAll(pTbl)=True then for i:=0 to pTbl.m_swAmMeter-1 do SetIndex(pTbl.m_sMeter[i].m_swMID);
End;
procedure CL2Editor.InitCombo;
Var
    pTable : QM_METERS;
    i : Integer;
Begin
    if m_pDB.GetMetersTypeTable(pTable) then
    Begin
     FsgGrid.Combobox.Items.Clear;
     m_nTypeList.Clear;
     for i:=0 to pTable.m_swAmMeterType-1 do
     Begin
      FsgGrid.Combobox.Items.Add(pTable.m_sMeterType[i].m_sName);
      m_nTypeList.Add(pTable.m_sMeterType[i].m_sName);
     End;
    End;
End;
//Edit Add Del Request mark del
procedure CL2Editor.OnEditNode;
begin
    m_byTrEditMode                  := ND_EDIT;
    ExecSetEditData(m_nIndex);
end;
procedure CL2Editor.OnAddNode;
begin
    m_byTrEditMode                  := ND_ADD; //  mark del
    //m_nIndex                        := GenIndex;
end;
procedure CL2Editor.OnDeleteNode;
Begin
    m_byTrEditMode                  := ND_DEL; //  mark del
    ExecSetEditData(m_nIndex);
End;
//Edit Add Del Execute
procedure CL2Editor.ExecSetEditData(nIndex:Integer);
Var
    m_sl2Tbl : SL2TAG;
Begin
    TraceL(1,0,'ExecSetEditData.');
    m_sl2Tbl.m_sbyPortID := m_nMasterIndex;
    m_sl2Tbl.m_swMID     := nIndex;
End;
procedure CL2Editor.ExecEditData;
Var
    m_sl2Tbl : SL2TAG;
Begin
    TraceL(1,0,'ExecEditData.');
End;
procedure CL2Editor.ExecAddData;
Var
    m_sl2Tbl : SL2TAG;
Begin
    TraceL(1,0,'ExecAddData.');
End;
procedure CL2Editor.OnSetForAll;
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
procedure CL2Editor.ExecDelData;
Begin
    TraceL(1,0,'ExecDelData.');
    m_pDB.DelMeterTable(m_nMasterIndex,m_nIndex);
End;
procedure CL2Editor.ExecInitLayer;
Begin
    TraceL(1,0,'ExecInitLayer.');
    //mL2Module.Init;
    //SendMSG(BOX_L3,DIR_L2TOL3,DL_STARTSNDR_IND);
End;
//Tree Reload
procedure CL2Editor.ExecSetTree;
Begin
    TraceL(1,0,'ExecSetTree.');
    //FTreeLoader.LoadTree;
End;
//Grid Routine
procedure CL2Editor.ExecSetGrid;
Var
    pTbl : SL2INITITAG;
    i : Integer;
Begin
    try
    FsgGrid.ClearNormalCells;
    if m_pDB.GetMetersTable(m_nMasterIndex,pTbl)=True then
    Begin
     m_nAmRecords := pTbl.m_swAmMeter;
     for i:=0 to pTbl.m_swAmMeter-1 do
     AddRecordToGrid(i,@pTbl.m_sMeter[i]);
     ViewDefault;
    End;
     except
     TraceER('(__)CL3MD::>Error In CL2Editor.ExecSetGrid!!!');
    end;
End;
procedure CL2Editor.ViewDefault;
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
procedure CL2Editor.AddRecordToGrid(nIndex:Integer;pTbl:PSL2TAG);
Var
   nY : Integer;
   nVisible : Integer;
Begin
    nY := nIndex+1;
    nVisible := round(FsgGrid.Height/21);                        
    //if (nY-nVisible)>0  then FsgGrid.TopRow := nY-nVisible;
    with pTbl^ do Begin
     FsgGrid.Cells[0,nY]  := IntToStr(nY);
     FsgGrid.Cells[1,nY]  := IntToStr(pullid);
     FsgGrid.Cells[2,nY]  := IntToStr(m_swVMID);
     FsgGrid.Cells[3,nY]  := IntToStr(m_nMasterIndex);
     FsgGrid.Cells[4,nY]  := IntToStr(m_swMID);
     FsgGrid.Cells[5,nY]  := m_nTypeList.Strings[m_sbyType];
     FsgGrid.Cells[6,nY]  := m_nMeterLocation.Strings[m_sbyLocation];
     FsgGrid.Cells[7,nY]  := m_sddFabNum;
     FsgGrid.Cells[8,nY]  := m_sddPHAddres;
     FsgGrid.Cells[9,nY]  := m_schPassword;
     FsgGrid.Cells[10,nY] := m_schName;
     FsgGrid.Cells[11,nY] := IntToStr(m_sbyRepMsg);
     FsgGrid.Cells[12,nY] := IntToStr(m_swRepTime);
     FsgGrid.Cells[13,nY] := FloatToStrF(m_sfKI,ffFixed,6,4);
     FsgGrid.Cells[14,nY] := FloatToStrF(m_sfKU,ffFixed,6,4);
     FsgGrid.Cells[15,nY] := FloatToStrF(m_sfMeterKoeff,ffFixed,6,4);

     FsgGrid.Cells[16,nY] := IntToStr(cDateTimeR.DateTimeToSec(m_sdtSumKor));
     FsgGrid.Cells[17,nY] := IntToStr(cDateTimeR.DateTimeToSec(m_sdtLimKor));
     FsgGrid.Cells[18,nY] := IntToStr(cDateTimeR.DateTimeToSec(m_sdtPhLimKor));

     FsgGrid.Cells[19,nY] := IntToStr(m_sbyPrecision);
     FsgGrid.Cells[20,nY] := IntToStr(m_swCurrQryTm);
     FsgGrid.Cells[21,nY] := m_nEsNoList.Strings[m_sbyTSlice];
     FsgGrid.Cells[22,nY] := m_sPhone;
     FsgGrid.Cells[23,nY] := m_nEsNoList.Strings[m_sbyModem];
     FsgGrid.Cells[24,nY] := m_nEsNoList.Strings[m_sbyEnable];
     FsgGrid.Cells[25,nY] := m_sAdvDiscL2Tag;
     FsgGrid.Cells[26,nY] := IntToStr(m_sbyStBlock);
     FsgGrid.Cells[27,nY] := m_sTariffs;
     FsgGrid.Cells[28,nY] := m_nEsNoList.Strings[m_bySynchro];
     with m_sAD do
     Begin
      FsgGrid.Cells[29,nY] := m_nEsNoList.Strings[m_sbyNSEnable];
      FsgGrid.Cells[30,nY] := IntToStr(m_sdwFMark);
      FsgGrid.Cells[31,nY] := IntToStr(m_sdwEMark);
      FsgGrid.Cells[32,nY] := IntToStr(m_sdwRetrans);
      FsgGrid.Cells[33,nY] := IntToStr(m_sdwKommut);
      FsgGrid.Cells[34,nY] := IntToStr(m_sdwDevice);
      FsgGrid.Cells[35,nY] := m_nSpeedListA.Strings[m_sbySpeed];
      FsgGrid.Cells[36,nY] := m_nParityListA.Strings[m_sbyParity];
      FsgGrid.Cells[37,nY] := m_nStopListA.Strings[m_sbyStop];
      FsgGrid.Cells[38,nY] := m_nDataListA.Strings[m_sbyKBit];
      FsgGrid.Cells[39,nY] := IntToStr(m_sbyPause);
      FsgGrid.Cells[40,nY] := IntToStr(m_nB0Timer);
     End;
     FsgGrid.Cells[41,nY] := IntToStr(m_swKE);
     FsgGrid.Cells[42,nY] := FloatToStr(m_sAktEnLose);
     FsgGrid.Cells[43,nY] := FloatToStr(m_sReaEnLose);
     FsgGrid.Cells[44,nY] := FloatToStr(m_sTranAktRes);
     FsgGrid.Cells[45,nY] := FloatToStr(m_sTranReaRes);
     FsgGrid.Cells[46,nY] := IntToStr(m_sGrKoeff);
     FsgGrid.Cells[47,nY] := IntToStr(m_sTranVolt);
     FsgGrid.Cells[48,nY] := m_sTpNum;
     FsgGrid.Cells[49,nY] := m_nTypeList.Strings[TYPEPU];
     FsgGrid.Cells[50,nY] := TYPEZVAZ;
     FsgGrid.Cells[51,nY] := TYPEABO;
     FsgGrid.Cells[52,nY] := IntToStr(m_aid_channel);
     FsgGrid.Cells[53,nY] := IntToStr(m_aid_tariff);
     FsgGrid.Cells[54,nY] := m_sddHOUSE;
     FsgGrid.Cells[55,nY] := m_sddKV;
    End;
    if nY>FsgGrid.RowCount then
    Begin
     FsgGrid.RowCount := FsgGrid.RowCount + 1;
     FsgGrid.RowHeights[nY-1] := nSizeFont+17;
    End;
End;

procedure CL2Editor.mnAutoUnLockClick;
var Year, Month, Day,
    Hour, Min, Sec, ms  : word;
    Mask                : word;
begin
   Mask := $4000;
   if (m_nRowIndex=-1) then exit;
   //m_pDB.UpdateBlStateMeter(StrToInt(FsgGrid.Cells[4,m_nRowIndex]), 4);
   SendL3Event(QRY_JRNL_T2,1, EVA_METER_ANSWER, StrToInt(FsgGrid.Cells[4,m_nRowIndex]), 0, Now);
end;

procedure CL2Editor.mnAutoLockClick;
var Year, Month, Day,
    Hour, Min, Sec, ms  : word;
    Mask                : word;
begin
   Mask := $4000;
   if (m_nRowIndex=-1) then exit;
   //m_pDB.UpdateBlStateMeter(StrToInt(FsgGrid.Cells[4,m_nRowIndex]), 8);
   SendL3Event(QRY_JRNL_T2,1, EVA_METER_NO_ANSWER, StrToInt(FsgGrid.Cells[4,m_nRowIndex]), 0, Now);
end;
procedure CL2Editor.SendL3Event(byType:Byte;byJrnType:Byte;wEvType:Word;nMID:Word;nPrm:Double;dtDate:TDateTime);
Var
   pMsg : CHMessage;
Begin
   pMsg.m_swLen      := 13+30;
   pMsg.m_swObjID    := nMID;
   pMsg.m_sbyType    := PH_EVENTS_INT;
   pMsg.m_sbyFor     := DIR_L2TOL3;
   pMsg.m_sbyFrom    := byJrnType;
   pMsg.m_sbyInfo[1] := byType;
   Move(wEvType,pMsg.m_sbyInfo[2],sizeof(Word));
   Move(nPrm,pMsg.m_sbyInfo[4],sizeof(Double));
   Move(dtDate,pMsg.m_sbyInfo[12],sizeof(TDateTime));
   if m_nCF.QueryType= QWR_QWERY_SRV then
   Begin
    //pMsg.m_swLen      := pMsg.m_swLen+sizeof(SQWERYCMDID);
    //Move(m_sQC,pMsg.m_sbyInfo[21],sizeof(SQWERYCMDID));
   End;
   FPUT(BOX_L3,@pMsg);
End;

procedure CL2Editor.OnSetGrid;
Begin
    ExecSetGrid;
End;
procedure CL2Editor.OnSaveGrid;
Var
    i      : Integer;
    pMETID : Integer;
    pTbl   : SL2TAG;
Begin
    try
    for i:=1 to FsgGrid.RowCount-1 do
    Begin
     if FsgGrid.Cells[m_nIDIndex,i]='' then break;
     pTbl.m_sbyID := i;
     GetGridRecord(pTbl);
     pMETID := m_pDB.addMeterId(pTbl);
     if pTbl.m_swMID<>-1 then pMETID := pTbl.m_swMID;
     m_pDB.InsertCommand(pMETID,pTbl.m_sbyType);
    End;
    ExecSetGrid;
    except
     TraceER('(__)CL3MD::>Error In CL2Editor.OnSaveGrid!!!');
    end;
End;
procedure CL2Editor.GetGridRecord(var pTbl:SL2TAG);
Var
    i : Integer;
Begin
    i := pTbl.m_sbyID;
    with pTbl do Begin
     m_sbyGroupID   := 0;
     pullid         := StrToInt(FsgGrid.Cells[1,i]);
     m_swVMID       := StrToInt(FsgGrid.Cells[2,i]);
     m_sbyPortID    := 0;
     M_SWABOID      := StrToInt(FsgGrid.Cells[3,i]);;
     m_swMID        := StrToInt(FsgGrid.Cells[4,i]);
     m_sbyType      := m_nTypeList.IndexOf(FsgGrid.Cells[5,i]);
     m_sbyLocation  := m_nMeterLocation.IndexOf(FsgGrid.Cells[6,i]);
     m_sddFabNum    := FsgGrid.Cells[7,i];
     m_sddPHAddres  := FsgGrid.Cells[8,i];
     m_schPassword  := FsgGrid.Cells[9,i];
     m_schName      := FsgGrid.Cells[10,i];
     m_sbyRepMsg    := StrToInt(FsgGrid.Cells[11,i]);
     m_swRepTime    := StrToInt(FsgGrid.Cells[12,i]);
     m_sfKI         := StrToFloat(FsgGrid.Cells[13,i]);
     m_sfKU         := StrToFloat(FsgGrid.Cells[14,i]);
     m_sfMeterKoeff := StrToFloat(FsgGrid.Cells[15,i]);
     m_sdtSumKor    := cDateTimeR.SecToDateTime(StrToInt(FsgGrid.Cells[16,i]));
     m_sdtLimKor    := cDateTimeR.SecToDateTime(StrToInt(FsgGrid.Cells[17,i]));
     m_sdtPhLimKor  := cDateTimeR.SecToDateTime(StrToInt(FsgGrid.Cells[18,i]));
     m_sbyPrecision := StrToInt(FsgGrid.Cells[19,i]);
     m_swCurrQryTm  := StrToInt(FsgGrid.Cells[20,i]);
     m_sbyTSlice    := m_nEsNoList.IndexOf(FsgGrid.Cells[21,i]);
     m_sPhone       := FsgGrid.Cells[22,i];
     m_sbyModem     := m_nEsNoList.IndexOf(FsgGrid.Cells[23,i]);
     m_sbyEnable    := m_nEsNoList.IndexOf(FsgGrid.Cells[24,i]);
     m_sAdvDiscL2Tag:= FsgGrid.Cells[25,i];
     m_sbyStBlock   := StrToInt(FsgGrid.Cells[26,i]);
     m_sTariffs     := FsgGrid.Cells[27,i];
     if FsgGrid.Cells[28,i]='' then FsgGrid.Cells[28,i] := m_nEsNoList.Strings[0];
     m_bySynchro    := m_nEsNoList.IndexOf(FsgGrid.Cells[28,i]);
     with m_sAD do
     Begin
      m_sbyNSEnable := m_nEsNoList.IndexOf(FsgGrid.Cells[29,i]);
      m_sdwFMark    := StrToInt(FsgGrid.Cells[30,i]);
      m_sdwEMark    := StrToInt(FsgGrid.Cells[31,i]);
      m_sdwRetrans  := StrToInt(FsgGrid.Cells[32,i]);
      m_sdwKommut   := StrToInt(FsgGrid.Cells[33,i]);
      m_sdwDevice   := StrToInt(FsgGrid.Cells[34,i]);
      m_sbySpeed    := m_nSpeedListA.IndexOf(FsgGrid.Cells[35,i]);
      m_sbyParity   := m_nParityListA.IndexOf(FsgGrid.Cells[36,i]);
      m_sbyStop     := m_nStopListA.IndexOf(FsgGrid.Cells[37,i]);
      m_sbyKBit     := m_nDataListA.IndexOf(FsgGrid.Cells[38,i]);
      m_sbyPause    := StrToInt(FsgGrid.Cells[39,i]);
      m_nB0Timer    := StrToInt(FsgGrid.Cells[40,i]);
     End;
     m_swKE         := StrToIntDef(FsgGrid.Cells[41,i], 2);
     m_sAktEnLose   := StrToFloat(FsgGrid.Cells[42,i]);
     m_sReaEnLose   := StrToFloat(FsgGrid.Cells[43,i]);
     m_sTranAktRes  := StrToFloat(FsgGrid.Cells[44,i]);
     m_sTranReaRes  := StrToFloat(FsgGrid.Cells[45,i]);
     m_sGrKoeff     := StrToInt(FsgGrid.Cells[46,i]);
     m_sTranVolt    := StrToInt(FsgGrid.Cells[47,i]);
     m_sTpNum       := FsgGrid.Cells[48,i];
     TYPEPU         := m_nTypeList.IndexOf(FsgGrid.Cells[49,i]);
     TYPEZVAZ       := FsgGrid.Cells[50,i];
     TYPEABO        := FsgGrid.Cells[51,i];
     m_aid_channel  := StrToInt(FsgGrid.Cells[52,i]);
     m_aid_tariff   := StrToInt(FsgGrid.Cells[53,i]);
     m_sddHOUSE     := FsgGrid.Cells[54,i];
     m_sddKV        := FsgGrid.Cells[55,i];
    End;
End;
procedure CL2Editor.SetDefaultRow(i:Integer);
Begin
    if FsgGrid.Cells[1,i]=''  then FsgGrid.Cells[1,i]  := '0';
    if FsgGrid.Cells[2,i]=''  then FsgGrid.Cells[2,i]  := '0';
    if FsgGrid.Cells[3,i]=''  then FsgGrid.Cells[3,i]  := IntToStr(m_nMasterIndex);
    if FsgGrid.Cells[4,i]=''  then FsgGrid.Cells[4,i]  := '-1';
    if FsgGrid.Cells[5,i]=''  then FsgGrid.Cells[5,i]  := 'SS301F3';
    if FsgGrid.Cells[6,i]=''  then FsgGrid.Cells[6,i]  := m_nMeterLocation.Strings[0];
    if FsgGrid.Cells[7,i]=''  then FsgGrid.Cells[7,i]  := '12345';
    if FsgGrid.Cells[8,i]=''  then FsgGrid.Cells[8,i]  := '0';
    if FsgGrid.Cells[9,i]=''  then FsgGrid.Cells[9,i]  := '0';
    if FsgGrid.Cells[10,i]='' then FsgGrid.Cells[10,i] := 'Meter '+FsgGrid.Cells[m_nIDIndex,i];
    if FsgGrid.Cells[11,i]='' then FsgGrid.Cells[11,i] := '3';
    if FsgGrid.Cells[12,i]='' then FsgGrid.Cells[12,i] := '3';
    if FsgGrid.Cells[13,i]='' then FsgGrid.Cells[13,i] := '1.0';
    if FsgGrid.Cells[14,i]='' then FsgGrid.Cells[14,i] := '1.0';
    if FsgGrid.Cells[15,i]='' then FsgGrid.Cells[15,i] := '1.0';
    if FsgGrid.Cells[16,i]='' then FsgGrid.Cells[16,i] := '0';
    if FsgGrid.Cells[17,i]='' then FsgGrid.Cells[17,i] := '3600';
    if FsgGrid.Cells[18,i]='' then FsgGrid.Cells[18,i] := '3600';
    if FsgGrid.Cells[19,i]='' then FsgGrid.Cells[19,i] := '3';
    if FsgGrid.Cells[20,i]='' then FsgGrid.Cells[20,i] := '40';
    if FsgGrid.Cells[21,i]='' then FsgGrid.Cells[21,i] := m_nEsNoList.Strings[0];
    if FsgGrid.Cells[22,i]='' then FsgGrid.Cells[22,i] := '80291730178';
    if FsgGrid.Cells[23,i]='' then FsgGrid.Cells[23,i] := m_nEsNoList.Strings[0];
    if FsgGrid.Cells[24,i]='' then FsgGrid.Cells[24,i] := m_nEsNoList.Strings[1];
    if FsgGrid.Cells[25,i]='' then FsgGrid.Cells[25,i] := '';
    if FsgGrid.Cells[26,i]='' then FsgGrid.Cells[26,i] := '0';
    if FsgGrid.Cells[27,i]='' then FsgGrid.Cells[27,i] := '1,2,3,4,';
    if FsgGrid.Cells[28,i]='' then FsgGrid.Cells[28,i] := m_nEsNoList.Strings[0];

    if FsgGrid.Cells[29,i]='' then FsgGrid.Cells[29,i] := m_nEsNoList.Strings[0];
    if FsgGrid.Cells[30,i]='' then FsgGrid.Cells[30,i] := '286261249';
    if FsgGrid.Cells[31,i]='' then FsgGrid.Cells[31,i] := '16781329';
    if FsgGrid.Cells[32,i]='' then FsgGrid.Cells[32,i] := '0';
    if FsgGrid.Cells[33,i]='' then FsgGrid.Cells[33,i] := '0';
    if FsgGrid.Cells[34,i]='' then FsgGrid.Cells[34,i] := '0';
    if FsgGrid.Cells[35,i]='' then FsgGrid.Cells[35,i] := '9600';
    if FsgGrid.Cells[36,i]='' then FsgGrid.Cells[36,i] := 'нет';
    if FsgGrid.Cells[37,i]='' then FsgGrid.Cells[37,i] := '1';
    if FsgGrid.Cells[38,i]='' then FsgGrid.Cells[38,i] := '8';
    if FsgGrid.Cells[39,i]='' then FsgGrid.Cells[39,i] := '15';
    if FsgGrid.Cells[40,i]='' then FsgGrid.Cells[40,i] := '0';
    if FsgGrid.Cells[41,i]='' then FsgGrid.Cells[41,i] := '2';
    if FsgGrid.Cells[42,i]='' then FsgGrid.Cells[42,i] := '0';
    if FsgGrid.Cells[43,i]='' then FsgGrid.Cells[43,i] := '0';
    if FsgGrid.Cells[44,i]='' then FsgGrid.Cells[44,i] := '0';
    if FsgGrid.Cells[45,i]='' then FsgGrid.Cells[45,i] := '0';
    if FsgGrid.Cells[46,i]='' then FsgGrid.Cells[46,i] := '0';
    if FsgGrid.Cells[47,i]='' then FsgGrid.Cells[47,i] := '0';
    if FsgGrid.Cells[48,i]='' then FsgGrid.Cells[48,i] := '';
    if FsgGrid.Cells[49,i]='' then FsgGrid.Cells[49,i] := 'SS301F3';
    if FsgGrid.Cells[50,i]='' then FsgGrid.Cells[50,i] := '0';
    if FsgGrid.Cells[51,i]='' then FsgGrid.Cells[51,i] := '1';

End;
procedure CL2Editor.ExecSelRowGrid;
Begin
    FsgGrid.SelectRows(FindRow(IntToStr(m_nIndex)),1);
    FsgGrid.Refresh;
    ViewChild(m_nIndex);
End;
function CL2Editor.FindRow(str:String):Integer;
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
procedure CL2Editor.ViewChild(nIndex:Integer);
Begin
    try
    if m_blCL2MetrEditor=False then
    if FChild<>Nil then
    Begin
     FChild.PMasterIndex := nIndex;
     if m_nRowIndex<>-1 then
     Begin
      FChild.PTypeIndex := m_nTypeList.IndexOf(FsgGrid.Cells[5,m_nRowIndex]);
      if(FsgGrid.Cells[8,m_nRowIndex]='')
      or(FChild.PTypeIndex=MET_KASKAD)
      or(FChild.PTypeIndex=MET_CE301BY)
      or(FChild.PTypeIndex=MET_MIRT1) then FChild.PFaddres := 0 else
      try
      FChild.PFaddres   := StrToInt(FsgGrid.Cells[8,m_nRowIndex]);
      except end
     End;
     FChild.ExecSetGrid;
    End;
    except

    end;
End;
function CL2Editor.FindFreeRow(nIndex:Integer):Integer;
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
procedure CL2Editor.OnAddRow;
Var
    nIndex : Integer;
Begin
    if m_nRowIndex<>-1 then
    Begin
     SetDefaultRow(m_nRowIndex);
    End else
    Begin
     nIndex := FindFreeRow(m_nIDIndex);
     SetDefaultRow(nIndex);
    End;
End;
procedure CL2Editor.OnCloneRow;
Var
    nIndex : Integer;
    pTbl   : SL2TAG;
Begin
    if m_nRowIndex<>-1 then
    if m_nRowIndex<=FindFreeRow(m_nIDIndex)-1 then
    Begin
     pTbl.m_sbyID   := m_nRowIndex;
     GetGridRecord(pTbl);
     pTbl.m_sddFabNum := 'x';
     pTbl.m_schName := 'x';
     pTbl.m_swMID := -1;
     AddRecordToGrid(FindFreeRow(m_nIDIndex)-1,@pTbl);
    End;
End;
procedure CL2Editor.OnDelRow;
Var
    nFind : Integer;
Begin
    if m_nAmRecords=FindFreeRow(m_nIDIndex)-1 then
    Begin
     if m_nIndex<>-1 then
     Begin
      m_pDB.DelMeterTable(m_nMasterIndex,m_nIndex);
      SetEdit;
      ExecSetGrid;
      ViewChild(m_nIndex);
     End;
    End else
    Begin
     if m_nRowIndex<>-1 then
     Begin
      FsgGrid.ClearRows(m_nRowIndex,1);
     End;
    End;
End;
procedure CL2Editor.OnDelAllRow;
Var
    i : Integer;
    pTbl : SL2INITITAG;
Begin
    m_pDB.DelMeterTable(m_nMasterIndex,-1);
    SetEdit;
    ExecSetGrid;
End;
procedure CL2Editor.OnClickGrid(Sender: TObject; ARow, ACol: Integer);
Begin
    m_nRowIndex   := -1;
    m_nRowIndexEx := -1;
    m_nColIndex   := ACol;
    if ARow>0 then Begin
     m_nRowIndex := ARow;
     m_nRowIndexEx := ARow;
     if FsgGrid.Cells[1,ARow]<>'' then
     Begin
      m_nIndex := StrToInt(FsgGrid.Cells[4,ARow]);
      ViewChild(m_nIndex);
     End else m_nIndex := -1;
    End;
End;
procedure CL2Editor.OnClickGridAbonId(Sender: TObject; ARow, ACol: Integer;var AbonId:Integer);
Begin
    m_nRowIndex   := -1;
    m_nRowIndexEx := -1;
    m_nColIndex   := ACol;
    if ARow>0 then Begin
     m_nRowIndex := ARow;
     m_nRowIndexEx := ARow;
     if FsgGrid.Cells[1,ARow]<>'' then
     Begin
      m_nIndex := StrToInt(FsgGrid.Cells[3,ARow]);
      //ViewChild(m_nIndex);
     End else m_nIndex := -1;
    End;
   AbonId:=m_nIndex;
End;
//Init Layer
procedure CL2Editor.OnInitLayer;
Begin
    //ExecSetTree;
    //ExecInitLayer;
End;
procedure CL2Editor.OnExecute(Sender: TObject);
Begin
    //TraceL(5,0,'OnExecute.');
    case m_byTrEditMode of //  mark del
     ND_EDIT : Begin ExecEditData;End;
     ND_ADD  : Begin ExecAddData;{ExecSetTree;}End;
     ND_DEL  : Begin ExecDelData;{ExecSetTree;}End;
    end;
    ExecSetGrid;
    //ExecInitLayer;
End;
//Color And Control
procedure CL2Editor.OnComboChandge(Sender: TObject; ACol, ARow,
               AItemIndex: Integer; ASelection: String);
Var
    nMType : Integer;
Begin
    {
    if ACol=5 then
    Begin
     nMType := m_nTypeList.IndexOf(FsgGrid.Cells[5,ARow]);
     m_pDB.InsertCommand(m_nIndex,AItemIndex);
     m_pDB.ReplaceVParams(nMType,m_nIndex);
     ViewChild(m_nIndex);
     //ExecSetGrid;
    End;
    }
End;
procedure CL2Editor.OnChannelGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
     OnGlGetCellColor(Sender,ARow,ACol,AState,ABrush,AFont);
end;
procedure CL2Editor.OnChannelGetCellType(Sender: TObject; ACol, ARow: Integer;var AEditor: TEditorType);
begin
    with FsgGrid^ do
    case ACol of
     5:Begin
        AEditor := edComboList;
        //combobox.items.loadfromfile(m_strCurrentDir+'MeterType.dat');
        InitCombo;
       End;
     6:Begin
        AEditor := edComboList;
        combobox.items.loadfromfile(m_strCurrentDir+'MeterLocation.dat');
       End;
     21,23,24:Begin
        AEditor := edComboList;
        combobox.items.loadfromfile(m_strCurrentDir+'Active.dat');
       End;
    end;
end;
function CL2Editor.GetComboIndex(cbCombo:TComboBox;str:String):Integer;
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
procedure CL2Editor.SendMSG(byBox,byFor,byType:Byte);
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

procedure CL2Editor.ExecMainEditor;
var m_nL2Node : SL2TAG;
    m_MID     : Integer;
begin
   if m_blCL2MetrEditor=False then
   if FsgGrid.Cells[m_nIDIndex,FsgGrid.Row] <> '' then
   begin
     m_MID := StrToInt(FsgGrid.Cells[m_nIDIndex, FsgGrid.Row]);
     m_pDB.GetMMeterTable(m_MID, m_nL2Node);
     m_nL2Node.m_sbyID := FsgGrid.Row;
     m_nL2Node.M_SWABOID:= StrToInt(FsgGrid.Cells[3, FsgGrid.Row]);
     //GetGridRecord(m_nL2Node);
     frMainEditor.pL2Node      := m_nL2Node;
     frMainEditor.byTypeEditor := EDT_MN_L2TAG;
     frMainEditor.ShowModal;
     OnSetGrid;
   end;
end;
procedure CL2Editor.OnSaveGridAdr(sNum,sAdres:string);
var i:integer;
adr:string;
begin
for i:=1 to FsgGrid.RowCount-1 do
   if (FsgGrid.Cells[7,i]= sNum)then
    begin
     adr:=FsgGrid.Cells[25,i];
     adr:=GetParceString(1,adr,sAdres);
     FsgGrid.Cells[25,i]:=adr;
     break;
    end;
end;

function CL2Editor.GetParceString(nID:Integer;sAdvDiscL2Tag,sAdres:String):String;
var
    i, j,pos : integer;
    ts: string;
begin
   j  := 0;
   ts := '';
   i:=1;
   while i<Length(sAdvDiscL2Tag) do
   begin
     if sAdvDiscL2Tag[i] = ';' then
      begin
        if (j=nID) then
          Begin
           if (sAdvDiscL2Tag[i+1]=';')then   //добавить если на новый объект и если там нету адресов
              insert(sAdres,sAdvDiscL2Tag,i+1)
           else
             begin
               pos:=i;
                 while pos< Length(sAdvDiscL2Tag) do
                   begin
                     if (sAdvDiscL2Tag[pos+1]<>';') then
                       pos:=pos+1
                     else
                       begin
                        delete(sAdvDiscL2Tag,i+1,pos-i);
                        insert(sAdres,sAdvDiscL2Tag,i+1);
                        break;
                       end;
                   end;
               end;
           result:=sAdvDiscL2Tag;
           exit;
          End
          else
      Inc(j);
     end;
     ts := ts + sAdvDiscL2Tag[i];
     Inc(i);
   end;
 result:=sAdvDiscL2Tag;
end;
end.

