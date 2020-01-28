unit knsl3szneditor;
interface
uses
Windows, Classes, SysUtils,SyncObjs,stdctrls,comctrls,utltypes,Messages,
  Graphics, Controls, Forms, Dialogs, Spin,extctrls,
  Grids, BaseGrid, AdvGrid,utlbox,utlconst,utldatabase,knsl1module,
  knsl3tarplaneeditor,knsl2treeloader,knsl5tracer,knsl5config,utlTimeDate,knsl5calendar,knsl3ZoneHandler,knsl3EventBox;
type
    CL3SznEditor = class
    Private
     FTreeModule    : PTTreeView;
     m_byTrState    : Byte;
     m_byTrEditMode : Byte;
     m_nPageIndex   : Integer;
     m_nIndex       : Integer;
     m_nRowIndex    : Integer;
     m_nColIndex    : Integer;
     m_nRowDIndex    : Integer;
     m_nColDIndex    : Integer;
     m_nRowIndexEx  : Integer;
     m_nIDIndex     : Integer;
     m_nAmRecords   : Integer;
     m_nMasterIndex : Integer;
     m_strCurrentDir: String;
     m_nTypeList    : TStringList;
     FsgGrid        : PTAdvStringGrid;
     FsgCGrid       : PTAdvStringGrid;
     FcbCmdCombo    : PTComboBox;
     FChild         : PCL3TarPlaneEditor;
     FTreeLoader    : PCTreeLoader;
     m_pDayTbl      : TM_SZNDAYS;
     m_pSZTbl       : TM_SZNTARIFFS;
     m_pPSZTbl      : PTM_SZNTARIFFS;
     FchHolyDay     : PTCheckBox;
     m_blIsCurrent  : Boolean;
     m_blIsCurZone  : Boolean;
     m_nYear  : Integer;
     m_nMonth : Integer;
     m_nDay   : Integer;
     m_nTDay  : Integer;
     m_nSZID  : Integer;
     m_npZH   : PCZoneHandler;
     FTestTimer : TTimer;
     FOpenTimer : TTimer;
     m_dwTestDate : TDateTime;
     m_nTehnoLen : Integer;
     constructor Create;
     function  FindRow(str:String):Integer;
     procedure ViewDefault;
     procedure ViewChild(nIndex:Integer);
     function  FindFreeRow(nIndex:Integer):Integer;
     procedure OnExecute(Sender: TObject);
     procedure ExecEditData;
     procedure ExecAddData;
     procedure ExecDelData;

     procedure AddRecordToGrid(nIndex:Integer;pTbl:PTM_SZNTARIFF);
     function  SetIndex(nIndex : Integer):Integer;
     function  GenIndex:Integer;
     function  GenIndexSv:Integer;
     procedure FreeIndex(nIndex : Integer);
     Procedure FreeAllIndex;
     procedure GetGridRecord(var pTbl:TM_SZNTARIFF);
     function  GetComboIndex(cbCombo:TComboBox;str:String):Integer;
     procedure SetDefaultRow(i:Integer);
     procedure InitCombo;
     procedure SznGenerate;
     procedure SznGenerateText;
     procedure SznSetColor(Sender: TObject;ARow,Acol:Integer; ABrush: TBrush; AFont: TFont);
     function  GetIndexTDay(nMonth,nDay:Integer):Integer;
     function  GetWorkTDay(nMonth,nDay:Integer):Integer;
     function  IsDayEnable(nMonth,nDay:Integer):Integer;
     procedure SznSetHolyDay;
     procedure DoHalfTestTime(Sender:TObject);dynamic;
     procedure DoHalfOpenTime(Sender:TObject);dynamic;
    Public
     procedure Init;
     procedure SetCurrentColor(nYear,nCurZone,nMonth,nDay,nTDay:Integer);
     procedure OnTestCalendar;
     procedure OnFormResize;
     procedure SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
     procedure OnChannelGetCellColor(Sender: TObject; ARow,
               ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
     procedure OnChannelGetCellType(Sender: TObject; ACol,
               ARow: Integer; var AEditor: TEditorType);
     procedure OnClickGrid(Sender: TObject; ARow, ACol: Integer);
     procedure OnMDownSZN(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
     procedure OnGetCellColorSznDay(Sender: TObject; ARow,
               ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
     procedure OnSZCellColor(Sender: TObject; ARow,
                ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
     procedure OnSelectSzTday(Sender: TObject; ACol, ARow: Integer;
               var CanSelect: Boolean);
     procedure OnClickCellTday(Sender: TObject; ARow, ACol: Integer);
     procedure OnGetEdTxtSzDay(Sender: TObject; ACol, ARow: Integer; var Value: String);
     procedure OnDrawTdayCell(Sender: TObject; ACol, ARow: Integer;Rect: TRect; State: TGridDrawState);
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
     procedure OnCreateSzn;
     procedure OnSetFreeDay(nIndex:Integer);
     procedure OnSaveGridTDay;
     procedure OnDelTDay;
     procedure OnDelTDays;
     procedure SetEditSz;
     procedure SetEditDy;
     procedure OpenInfo;
     procedure CloseInfo;
    Public
     property Pm_npZH     :PCZoneHandler      read m_npZH         write m_npZH;
     property PTreeModule :PTTreeView         read FTreeModule    write FTreeModule;
     property PsgGrid     :PTAdvStringGrid    read FsgGrid        write FsgGrid;
     property PsgCGrid    :PTAdvStringGrid    read FsgCGrid       write FsgCGrid;
     property PcbCmdCombo :PTComboBox         read FcbCmdCombo    write FcbCmdCombo;
     property PPageIndex  :Integer            read m_nPageIndex   write m_nPageIndex;
     property PIndex      :Integer            read m_nIndex       write m_nIndex;
     property PMasterIndex:Integer            read m_nMasterIndex write m_nMasterIndex;
     property PChild      :PCL3TarPlaneEditor read FChild         write FChild;
     property PTreeLoader :PCTreeLoader       read FTreeLoader    write FTreeLoader;
     property PchHolyDay  :PTCheckBox         read FchHolyDay     write FchHolyDay;
    End;
implementation
constructor CL3SznEditor.Create;
Begin

End;
{
TM_TARIFF = packed record
     m_swID    : Word;
     m_swTID   : Word;
     m_swSZNID  : Word;
     m_snFTime : TDateTime;
     m_snETime : TDateTime;
     m_swSZNName   : String[100];
    End;
    TM_TARIFFS = packed record
     m_swID       : Word;
     m_swSZNID     : Word;
     m_swSZNName      : String[100];
     m_swCMDID    : Word;
     m_snFTime    : TDateTime;
     m_snETime    : TDateTime;
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
procedure CL3SznEditor.Init;
Var
    i,j : Integer;
Begin
    //if(m_npZH=Nil) then m_npZH := CZoneHandler.Create;
    //m_npZH.Init;
    m_blIsCurrent := False;
    m_blIsCurZone := False;
    m_nSZID  := -1;
    m_nMonth := 1;
    m_nDay   := -1;
    m_nYear  := -1;
    m_nTDay  := SZN_WORK_DAY;
    m_strCurrentDir := ExtractFilePath(Application.ExeName) + '\\Settings\\';
    for i:=0 to MAX_TTYPE do m_blSznTypeIndex[i] := True;
    m_nRowIndex         := -1;
    m_nColIndex         := -1;
    m_nRowDIndex        := -1;
    m_nColDIndex        := -1;
    m_nRowIndexEx       := 1;
    m_nIDIndex          := 2;
    FsgGrid.Color       := KNS_NCOLOR;
    FsgGrid.ColCount    := 7;
    FsgGrid.RowCount    := 15;
    FsgGrid.Cells[0,0]  := '№/T';
    FsgGrid.Cells[1,0]  := 'ID';
    FsgGrid.Cells[2,0]  := 'SID';
    FsgGrid.Cells[3,0]  := 'Название';
    FsgGrid.Cells[4,0]  := 'Начало';
    FsgGrid.Cells[5,0]  := 'Окончание';
    FsgGrid.Cells[6,0]  := 'Активность';
    FsgGrid.ColWidths[0]:= 25;
    FsgGrid.ColWidths[1]:= 0;
    FsgGrid.ColWidths[2]:= 0;
    FsgGrid.ColWidths[3]:= 0;
    m_nTehnoLen         := 0+0+0;
    //SetHigthGrid(FsgGrid^,20);
    SetHigthGrid(FsgCGrid^,19);

    for i:=1 to 400 do
    Begin
     m_pDayTbl.Items[i].m_sbyEnable := 0;
     m_pDayTbl.Items[i].m_swTDayID  := SZN_WORK_DAY;
    End;
    FsgCGrid.ColCount    := 32;
    FsgCGrid.RowCount    := 13;
    FsgCGrid.Cells[0,0]  := 'Мс\Дн';
    for j:=1 to 31 do
    FsgCGrid.Cells[j,0]  := IntToStr(j);
    for i:=1 to 12 do
    Begin
     FsgCGrid.Cells[0,i] := cDateTimeR.GetNameMonth0(i);
     //for j:=1 to 31 do
     //FsgCGrid.Cells[j,i] := IntToStr(j);
    End;
    FsgCGrid.ColWidths[0]:= 50;
    OnFormResize;
    ExecSetGrid;
    if FsgGrid.Cells[2,2]<>'' then
    Begin
     m_nRowIndex := 2;
     OnCreateSzn;
    End;
    FChild.PChild.PPSZTbl := @m_pSZTbl;

    FTestTimer         := TTimer.Create(Nil);
    FTestTimer.Enabled := False;
    FTestTimer.Interval:= 1000;
    FTestTimer.OnTimer := DoHalfTestTime;

    FOpenTimer         := TTimer.Create(Nil);
    FOpenTimer.Enabled := True;
    FOpenTimer.Interval:= 10000;
    FOpenTimer.OnTimer := DoHalfOpenTime;
End;
procedure CL3SznEditor.OpenInfo;
Begin
    FsgGrid.ColWidths[0]:= 25;
    FsgGrid.ColWidths[1]:= 25;
    FsgGrid.ColWidths[2]:= 25;
    FsgGrid.ColWidths[3]:= 60;
    m_nTehnoLen         := 0+25+25+60;
    OnFormResize;
End;
procedure CL3SznEditor.CloseInfo;
Begin
    FsgGrid.ColWidths[0]:= 25;
    FsgGrid.ColWidths[1]:= 0;
    FsgGrid.ColWidths[2]:= 0;
    FsgGrid.ColWidths[3]:= 0;
    m_nTehnoLen         := 0+0+0;
    OnFormResize;
End;
procedure CL3SznEditor.SetHigthGrid(var sgGrid:TAdvStringGrid;nHigth:Integer);
Var
    i : Integer;
Begin
    for i:=0 to sgGrid.RowCount-1 do Begin sgGrid.Cells[0,i+1] := IntToStr(i+1); sgGrid.RowHeights[i]:= nHigth;End;
End;
procedure CL3SznEditor.OnFormResize;
Var
    i : Integer;
Begin
    for i:=4 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-(m_nTehnoLen)-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1-3));
    for i:=1 to FsgCGrid.ColCount-1 do FsgCGrid.ColWidths[i] := trunc((FsgCGrid.Width-FsgCGrid.ColWidths[0])/(FsgCGrid.ColCount-1-0));
    //FsgCGrid.Refresh;
    //FChild.OnFormResize;
End;
procedure CL3SznEditor.SetEditSz;
Var
    i : Integer;
Begin
    m_nRowIndex := -1;
    m_nColIndex := -1;
    FreeAllIndex;
    if m_pDB.GetSZTarifsTable(m_pSZTbl)=True then for i:=0 to m_pSZTbl.Count-1 do SetIndex(m_pSZTbl.Items[i].m_swSZNID);
End;
procedure CL3SznEditor.SetEditDy;
Begin
    m_nRowDIndex := -1;
    m_nColDIndex := -1;
End;
{
  SZN_WORK_DAY    = 0;
  SZN_SATR_DAY    = 1;
  SZN_HOLY_DAY    = 2;
}
procedure CL3SznEditor.OnCreateSzn;
Begin
    //m_npZH.Init;
    //m_npZH.Enable;
    //m_nSZID := -1;
    SznGenerate;
    SznSetHolyDay;
    SznGenerateText;
    //FChild.PChild.PTDay := GetWorkTDay(m_nRowDIndex,m_nColDIndex);
    //FsgCGrid.Refresh;
End;
procedure CL3SznEditor.SznGenerateText;
Var
     Month,Day,nI,DayPW:Integer;
Begin
     for Month:=1 to 12 do
     for Day  :=1 to 31 do
     Begin
     nI    := (Month-1)*31 + Day;
     if nI>400 then exit;
     with m_pDayTbl.Items[nI] do
     Begin
      if m_sbyEnable=1 then
      Begin
       DayPW   := m_swTDayID shr 4;
       if (DayPW>=1) and (DayPW<=7) then FsgCGrid.Cells[Day,Month] :=chDays[DayPW];
      End else
      if m_sbyEnable<>1 then FsgCGrid.Cells[Day,Month] :=' ';
     End;
     End;
End;
procedure CL3SznEditor.SznGenerate;
Var
    dt0,dt1 : TDateTime;
    nSZID   : Byte;
    i       : Integer;
    Year,Month,Day : Word;
    nIndex  : Integer;
    ntDay,tDay,nI : Integer;
Begin
    for i:=1 to 400 do
    Begin
     m_pDayTbl.Items[i].m_sbyEnable := 0;
     m_pDayTbl.Items[i].m_swTDayID  := SZN_WORK_DAY;
    End;
    if m_nRowIndex=-1 then exit;
    if FsgGrid.Cells[4,m_nRowIndex]<>'' then
    Begin
     i := 0;
     dt0   := round(StrToDateTime(FsgGrid.Cells[4,m_nRowIndex]));
     dt1   := round(StrToDateTime(FsgGrid.Cells[5,m_nRowIndex]));
     nSZID := StrToInt(FsgGrid.Cells[2,m_nRowIndex]);
     while dt0<=dt1 do
     Begin
      DecodeDate(dt0,Year,Month,Day);
      ntDay := DayOfWeek(dt0);
      nI    := GetIndexTDay(Month,Day);
      with m_pDayTbl.Items[nI] do
      Begin
       m_swSZNID    := nSZID;
       m_swMntID    := Month;
       m_swDayID    := Day;
       m_swTDayID   := (ntDay*16)+SZN_WORK_DAY;
       if (ntDay=7)or(ntDay=1) then m_swTDayID := (ntDay*16)+SZN_SATR_DAY;
       m_sbyEnable  := 1;

       if ((m_swMntID=5)and(m_swDayID=9)){or ((m_swMntID=10)and(m_swDayID=7))} then
        Begin
         if FchHolyDay.Checked=True then
         Begin
          m_swTDayID := (ntDay*16)+SZN_HOLY_DAY;
          m_pDB.AddSZDayTable(m_pDayTbl.Items[nI]);
         End;
        End;

      End;
      Inc(i);
      dt0 := dt0 + 1;
     End;
     m_pDayTbl.Count := i;
    End;
End;
procedure CL3SznEditor.SznSetHolyDay;
Var
    pTbl : TM_SZNDAYS;
    i,nI : Integer;
Begin
    if m_pDB.GetSZDayTable(FChild.PChild.PSZone,pTbl)=True then
    Begin
     for i:=1 to pTbl.Count do
     Begin
      with pTbl.Items[i] do
      Begin
       nI := GetIndexTDay(m_swMntID,m_swDayID);
       m_pDayTbl.Items[nI].m_swTDayID := m_swTDayID;
      End;
     End;
    End;
End;
procedure CL3SznEditor.OnTestCalendar;
Begin
    m_npZH.Init;
    m_npZH.Enable;
    if FTestTimer.Enabled=False then
    Begin
     m_npZH.Disable;
     FTestTimer.Interval := 400;
     FTestTimer.Enabled := True;
     if m_nIndex<>-1 then
     m_dwTestDate := m_pSZTbl.Items[m_nIndex].m_snFTime else
     m_dwTestDate := m_pSZTbl.Items[0].m_snFTime;
    End else
    if FTestTimer.Enabled=True  then
    Begin
     m_npZH.Enable;
     //FTestTimer.Interval := 10000;
     FTestTimer.Enabled := False;
    End;
End;
{
//Типы дней
  SZN_WORK_DAY    = 0;
  SZN_SATR_DAY    = 1;
  SZN_HOLY_DAY    = 2;
  SZN_WRST_DAY    = 3;
}
procedure CL3SznEditor.DoHalfOpenTime(Sender:TObject);
Var
    nYear,nCurZone,nCurMont,nCurDay,nCurWDay,nCurTDay:Integer;
Begin
    if (FTestTimer.Enabled=False)and(m_nCF.IsCalendOn=True) then
    Begin
     m_npZH.FindZone(Now,nCurZone,nCurMont,nCurDay,nCurWDay,nCurTDay);
     SetCurrentColor(0,nCurZone,nCurMont,nCurDay,nCurTDay);
    End;
End;
procedure CL3SznEditor.DoHalfTestTime(Sender:TObject);
Var
    nYear,nCurZone,nCurMont,nCurDay,nCurWDay,nCurTDay:Integer;
    res : Boolean;
Begin
    res := m_npZH.FindZone(m_dwTestDate,nCurZone,nCurMont,nCurDay,nCurWDay,nCurTDay);
    m_npZH.UpdateText(m_dwTestDate);
    if EventBox<>Nil then EventBox.FixEvents(ET_NORMAL,'Дата:'+DateTimeToStr(m_dwTestDate)+' Зона:'+m_npZH.ZoneToStr(nCurZone)+' Месяц:'+m_npZH.MonthToStr(nCurMont)+' День:'+IntToStr(nCurDay)+':'+m_npZH.WeekToStr(nCurWDay)+' Тип дня:'+m_npZH.TDayToStr(nCurTDay));
    SetCurrentColor(Integer(res),nCurZone,nCurMont,nCurDay,nCurTDay);
    if res=False then Begin {m_nDay:=-1;}EventBox.FixEvents(ET_CRITICAL,'Внимание! Даты:'+DateTimeToStr(m_dwTestDate)+' нет в календаре! Переход на Зону :'+m_npZH.ZoneToStr(nCurZone)+' Месяц:'+m_npZH.MonthToStr(nCurMont)+' День:'+IntToStr(nCurDay)+':'+m_npZH.WeekToStr(nCurWDay)+' Тип дня:'+m_npZH.TDayToStr(nCurTDay));End;
    m_dwTestDate := m_dwTestDate + 1;
End;
procedure CL3SznEditor.SetCurrentColor(nYear,nCurZone,nMonth,nDay,nTDay:Integer);
Var
    i : Integer;
Begin
    if (m_nSZID<>nCurZone) then
    for i:=1 to FsgGrid.RowCount-1 do
    Begin
     if (FsgGrid.Cells[2,i]<>'')and(StrToInt(FsgGrid.Cells[2,i])=nCurZone) then
     Begin
      FsgGrid.SelectRows(i,1);
      OnClickGrid(FsgGrid^,i,1);
      m_blIsCurZone := True;
      break;
     End;
    End;
    if (m_nDay<>nDay)or(nYear=0)or(m_nYear=0) then
    Begin
     FsgCGrid.Cells[nDay,nMonth] := FsgCGrid.Cells[nDay,nMonth];
     m_blIsCurrent := True;
    End;
    if m_nTDay<>nTDay then
    OnClickCellTday(FsgCGrid^,nMonth,nDay);
    m_nYear  := nYear;
    m_nMonth := nMonth;
    m_nSZID  := nCurZone;
    m_nDay   := nDay;
    m_nTDay  := nTDay;
End;
procedure CL3SznEditor.SznSetColor(Sender: TObject;ARow,Acol:Integer;ABrush: TBrush; AFont: TFont);
Var
    DayType,DayPW : Word;
Begin
    if (m_blIsCurrent=True)and(m_nMonth=ARow)and(m_nDay=Acol) then
    Begin
     m_blIsCurrent := False;
     AFont.Size    := 8;
     case m_nTDay of
       SZN_WORK_DAY : Begin ABrush.Color := clGreen;  AFont.Color :=  clBlack; End;
       SZN_SATR_DAY : Begin ABrush.Color := clRed;   AFont.Color :=  clBlack; End;
       SZN_HOLY_DAY : Begin ABrush.Color := clFuchsia-50; AFont.Color :=  clWhite; End;
     End;
    End else
    with m_pDayTbl.Items[GetIndexTDay(ARow,ACol)] do
    Begin
     if m_sbyEnable=1 then
     Begin
      DayType     := m_swTDayID and $0f;
      DayPW       := m_swTDayID shr 4;
      AFont.Size  :=  9;
      // Green    Red      Yellow
      //$7FFF00, $6A6AFF, $00FFFF
      case DayType of
       SZN_WORK_DAY : Begin ABrush.Color := $7FFF00; AFont.Color  :=  clBlack; End;
       SZN_SATR_DAY : Begin ABrush.Color := $6A6AFF; AFont.Color  :=  clBlack; End;
       SZN_HOLY_DAY : Begin ABrush.Color := clFuchsia; AFont.Color:=  clBlack; End;
       SZN_WRST_DAY : Begin ABrush.Color := clFuchsia;AFont.Color :=  clBlack; End;
      End;
     End else ABrush.Color := clWhite;
    End;
    //(Sender as TAdvStringGrid).Canvas.Brush.Color := clColor;
    //(Sender as TAdvStringGrid).Canvas.FillRect(Rect);
End;
procedure CL3SznEditor.OnSetFreeDay(nIndex:Integer);
Var
    nWDay,nWNewDay,nI : Integer;
Begin
    if m_blCL3SznTDayEditor=True then
    if not((m_nRowDIndex=-1)and(m_nColDIndex=-1)) then
    Begin
     nI := GetIndexTDay(m_nRowDIndex,m_nColDIndex);
     with m_pDayTbl.Items[nI] do
     Begin
      if m_sbyEnable=1 then
      Begin
       nWDay := m_swTDayID and $0f;
       m_swTDayID := m_swTDayID and $f0;
       //if (nWDay=SZN_SATR_DAY)and(nIndex=SZN_WORK_DAY) then m_swTDayID := m_swTDayID + SZN_WRST_DAY else
       //if ((nWDay=SZN_HOLY_DAY)or(nWDay=SZN_WRST_DAY))and(nIndex=SZN_WORK_DAY) then OnDelTDay;
       if (nWDay=SZN_HOLY_DAY)and(nIndex=SZN_WORK_DAY) then OnDelTDay;
       m_swTDayID := m_swTDayID + nIndex;
       m_pDB.AddSZDayTable(m_pDayTbl.Items[nI]);
      end;
     end;
    End;
End;
procedure CL3SznEditor.OnSaveGridTDay;
Var
     Month,Day,nI,DayPW:Integer;
Begin
     for Month:=1 to 12 do
     for Day  :=1 to 31 do
     Begin
      nI    := (Month-1)*31 + Day;
      if nI>400 then exit;
      with m_pDayTbl.Items[nI] do
      Begin
       DayPW := m_swTDayID and $0f;
       //if (DayPW=SZN_HOLY_DAY)or(DayPW=SZN_WRST_DAY) then
       if (DayPW=SZN_HOLY_DAY) then
       m_pDB.AddSZDayTable(m_pDayTbl.Items[nI]);
      End;
     End;
End;
procedure CL3SznEditor.OnDelTDay;
Begin
     if not((m_nRowIndex=-1)and(m_nRowDIndex=-1)and(m_nColDIndex=-1)) then
     m_pDB.DelSZDayTable(m_nIndex,m_nRowDIndex,m_nColDIndex);
     OnCreateSzn;
End;
procedure CL3SznEditor.OnDelTDays;
Begin
     if not((m_nRowIndex=-1)) then
     m_pDB.DelSZDayTable(m_nIndex,-1,-1);
     OnCreateSzn;
End;
procedure CL3SznEditor.OnGetEdTxtSzDay(Sender: TObject; ACol, ARow: Integer; var Value: String);
Begin
    {
    with m_pDayTbl.Items[GetIndexTDay(ARow,ACol)] do
    Begin
     if m_sbyEnable=1  then Value :=chDays[m_swTDayID shr 4] else
     if m_sbyEnable<>1 then Value := '-';
    End;
    }
End;
function CL3SznEditor.GetIndexTDay(nMonth,nDay:Integer):Integer;
Var
    nIndex : Integer;
Begin
    Result := 0;
    if (nMonth <> 0) and (nDay<>0) then
    Begin
     nIndex := (nMonth-1)*31 + nDay;
     if nIndex<400 then Result := nIndex;
    End;
End;
function  CL3SznEditor.GetWorkTDay(nMonth,nDay:Integer):Integer;
Begin
    Result := m_pDayTbl.Items[GetIndexTDay(nMonth,nDay)].m_swTDayID and $0f;
End;
function  CL3SznEditor.IsDayEnable(nMonth,nDay:Integer):Integer;
Begin
    Result := m_pDayTbl.Items[GetIndexTDay(nMonth,nDay)].m_sbyEnable;
End;
//Color And Control
procedure CL3SznEditor.OnDrawTdayCell(Sender: TObject; ACol, ARow: Integer;Rect: TRect; State: TGridDrawState);
Begin
    //if (ACol <> 0) and (ARow<>0) then
    //SznSetColor(Sender,ARow,Acol,Rect,State);
End;
procedure CL3SznEditor.OnGetCellColorSznDay(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
    with (Sender AS TAdvStringGrid)  do
    Begin
     if (ACol <> 0) and (ARow<>0) and (ARow < RowCount) and
     (not(gdSelected in AState) or (gdFocused in AState)) then
     begin
      SznSetColor(Sender,ARow,Acol,ABrush,AFont);
      if (ARow=0)or(ACol=0) then AFont.Style := [fsBold];
     {
      if (ACol<>0)and(ARow<>0) then
      ABrush.Color := clTeal;
     }
     end;
    {
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
     }
    End;
end;
procedure  CL3SznEditor.OnSZCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
    with (Sender AS TAdvStringGrid)  do Begin
    if (ACol <> 0) and (ARow<>0) and (ARow < RowCount) and
     (not(gdSelected in AState) or (gdFocused in AState)) then
    begin
    if (m_blIsCurZone=True)and(m_nSZID=ACol) then
    Begin
     //m_blIsCurZone := False;
     //ABrush.Color := clRed;
    End;

    {if (ACol<>0)and(ARow<>0) then
     ABrush.Color := clTeal; }
    end;
    End;
end;
procedure CL3SznEditor.OnSelectSzTday(Sender: TObject; ACol, ARow: Integer;var CanSelect: Boolean);
Begin
    OnClickCellTday(Sender,ACol,ARow);
End;
procedure CL3SznEditor.OnClickCellTday(Sender: TObject; ARow, ACol: Integer);
Begin
     m_nRowDIndex   := -1;
     m_nColDIndex   := -1;
     m_nDay         := -1; 
     if (ARow>0) and (ACol>0)then
     Begin
      m_nRowDIndex := ARow;
      m_nColDIndex := ACol;
      if (m_blCL3SznTDayEditor=False)and(m_blCL3SznEditor=False) then
      Begin
       if(IsDayEnable(m_nRowDIndex,m_nColDIndex)=1) then
       Begin
        FChild.PChild.PTDay := GetWorkTDay(m_nRowDIndex,m_nColDIndex);
        FChild.ExecSetGrid;
       End;
      End;
     End;
End;

procedure CL3SznEditor.InitCombo;
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
      //FsgGrid.Combobox.Items.Add(pTable.m_sMeterType[i].m_swSZNName);
      //m_nTypeList.Add(pTable.m_sMeterType[i].m_swSZNName);
     End;
    End;
End;
//Edit Add Del Request
procedure CL3SznEditor.OnEditNode;
begin
end;
procedure CL3SznEditor.OnAddNode;
begin
end;
procedure CL3SznEditor.OnDeleteNode;
Begin
End;
//Edit Add Del Execute
procedure CL3SznEditor.ExecSetEditData(nIndex:Integer);
Begin
    TraceL(1,0,'ExecSetEditData.');
End;
procedure CL3SznEditor.ExecEditData;
Begin
    TraceL(1,0,'ExecEditData.');
End;
procedure CL3SznEditor.ExecAddData;
Begin
    TraceL(1,0,'ExecAddData.');
End;
procedure CL3SznEditor.ExecDelData;
Begin
    TraceL(1,0,'ExecDelData.');
End;
procedure CL3SznEditor.ExecInitLayer;
Begin
    TraceL(1,0,'ExecInitLayer.');
    //mL2Module.Init;
End;
//Tree Reload
procedure CL3SznEditor.ExecSetTree;
Begin
    TraceL(1,0,'ExecSetTree.');
    //FTreeLoader.LoadTree;
End;
//Grid Routine
procedure CL3SznEditor.ExecSelRowGrid;
Begin
    FsgGrid.SelectRows(FindRow(IntToStr(m_nIndex)),1);
    FsgGrid.Refresh;
    ViewChild(m_nIndex);
End;
function CL3SznEditor.FindRow(str:String):Integer;
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
procedure CL3SznEditor.ViewChild(nIndex:Integer);
Begin
    try
    if FChild<>Nil then
    Begin
     if (m_blCL3SznEditor=False)and(m_blCL3SznTDayEditor=False) then
     Begin
      if m_nRowIndex=-1 then m_nRowIndex:=1;
      FChild.PChild.PSZTm0 := m_pSZTbl.Items[m_nRowIndex-1].m_snFTime;
      FChild.PChild.PSZTm1 := m_pSZTbl.Items[m_nRowIndex-1].m_snETime;
      FChild.PChild.PSZone := nIndex;
      OnCreateSzn;
      if(IsDayEnable(m_nRowDIndex,m_nColDIndex)=1) then
      Begin
       FChild.PChild.PTDay := GetWorkTDay(m_nRowDIndex,m_nColDIndex);
       FChild.ExecSetGrid;
      End;
     End;
    End;
    except
     TraceER('(__)CL3MD::>Error In CL3SznEditor.ViewChild!!!');
    end;
End;
procedure CL3SznEditor.ExecSetGrid;
Var
    i : Integer;
Begin
    FsgGrid.ClearNormalCells;
    //FreeAllIndex;
    if m_pDB.GetSZTarifsTable(m_pSZTbl)=True then
    Begin
     m_nAmRecords := m_pSZTbl.Count;
     for i:=0 to m_pSZTbl.Count-1 do
     Begin
      SetIndex(m_pSZTbl.Items[i].m_swSZNID);
      AddRecordToGrid(i,@m_pSZTbl.Items[i]);
     End;
     ViewDefault;
    End;
End;
procedure CL3SznEditor.ViewDefault;
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
 TM_SZNTARIFF = packed record
     m_swID       : Integer;
     m_swSZNID    : Integer;
     m_swSZNName  : String[100];
     m_snFTime    : TDateTime;
     m_snETime    : TDateTime;
     m_sbyEnable  : Byte;
    End;
    PTM_SZNTARIFF =^ TM_SZNTARIFF;
    TM_SZNTARIFFS = packed record
     Count        : Word;
     Items        : array of TM_SZNTARIFF;
    End;
    TM_SZNDAY = packed record
     m_swID       : Integer;
     m_swSZNID    : Byte;
     m_swMntID    : Byte;
     m_swDayID    : Byte;
     m_swTDayID   : Byte;
     m_sbyEnable  : Byte;
    End;
    TM_SZNDAYS = packed record
     Count        : Word;
     Items        : array of TM_SZNDAY;
    End;
}
procedure CL3SznEditor.AddRecordToGrid(nIndex:Integer;pTbl:PTM_SZNTARIFF);
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
     FsgGrid.Cells[2,nY] := IntToStr(m_swSZNID);
     FsgGrid.Cells[3,nY] := m_swSZNName;
     FsgGrid.Cells[4,nY] := DateTimeToStr(m_snFTime);
     FsgGrid.Cells[5,nY] := DateTimeToStr(m_snETime);
     FsgGrid.Cells[6,nY] := m_nEsNoList.Strings[m_sbyEnable];
    End;
End;
procedure CL3SznEditor.OnSetGrid;
Begin
    ExecSetGrid;
End;
procedure CL3SznEditor.OnSaveGrid;
Var
    i : Integer;
    pTbl:TM_SZNTARIFF;
Begin
    for i:=1 to FsgGrid.RowCount-1 do
    Begin
     if FsgGrid.Cells[3,i]='' then break;
     pTbl.m_swID := i;
     GetGridRecord(pTbl);
     if m_pDB.AddSZTarifTable(pTbl)=True then SetIndex(pTbl.m_swSZNID);
    End;
    ExecSetGrid;
End;
function CL3SznEditor.FindFreeRow(nIndex:Integer):Integer;
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
procedure CL3SznEditor.GetGridRecord(var pTbl:TM_SZNTARIFF);
Var
    i : Integer;
    str : String;
Begin
    i := pTbl.m_swID;
    with pTbl do Begin
     SetDefaultRow(i);
     m_swID       := StrToInt(FsgGrid.Cells[1,i]);
     m_swSZNID    := StrToInt(FsgGrid.Cells[2,i]);
     m_swSZNName  := FsgGrid.Cells[3,i];
     m_snFTime    := StrToDateTime(FsgGrid.Cells[4,i]);
     m_snETime    := StrToDateTime(FsgGrid.Cells[5,i]);
     m_sbyEnable := m_nEsNoList.IndexOf(FsgGrid.Cells[6,i]);
    End;
End;
procedure CL3SznEditor.OnAddRow;
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
procedure CL3SznEditor.OnCloneRow;
Var
    nIndex : Integer;
    pTbl   : TM_SZNTARIFF;
Begin
    if m_nRowIndex<>-1 then
    if m_nRowIndex<=FindFreeRow(3)-1 then
    Begin
     pTbl.m_swID   := m_nRowIndex;
     GetGridRecord(pTbl);
     pTbl.m_swSZNID := GenIndexSv;
     AddRecordToGrid(FindFreeRow(3)-1,@pTbl);
    End;
End;
procedure CL3SznEditor.SetDefaultRow(i:Integer);
Begin
    if FsgGrid.Cells[1,i]='' then FsgGrid.Cells[1,i] := '-1';
    if FsgGrid.Cells[2,i]='' then FsgGrid.Cells[2,i] := IntToStr(GenIndex);
    if FsgGrid.Cells[3,i]='' then FsgGrid.Cells[3,i] := 'Зима-Лето';
    if FsgGrid.Cells[4,i]='' then FsgGrid.Cells[4,i] := DateToStr(Now);
    if FsgGrid.Cells[5,i]='' then FsgGrid.Cells[5,i] := DateToStr(Now);
    if FsgGrid.Cells[6,i]='' then FsgGrid.Cells[6,i] := m_nEsNoList.Strings[1];
End;
procedure CL3SznEditor.OnClickGrid(Sender: TObject; ARow, ACol: Integer);
Begin
    m_nRowIndex   := -1;
    m_nColIndex   := -1;
    m_nRowIndexEx := -1;
    m_nSZID       := -1;
    if (ARow>0) and (ACol>0)then Begin
     m_nRowIndex   := ARow;
     m_nRowIndexEx := ARow;
     m_nColIndex   := ACol;
     if FsgGrid.Cells[m_nIDIndex,ARow]<>'' then
     Begin
      m_nIndex := StrToInt(FsgGrid.Cells[m_nIDIndex,ARow]);
      ViewChild(m_nIndex);
     End else m_nIndex := -1;
    End;
End;
procedure CL3SznEditor.OnDelRow;
Var
    nFind : Integer;
    m_pPLTbl : TM_PLANES;
    i,j,k:Integer;
Begin
    if m_nAmRecords=FindFreeRow(3)-1 then
    Begin
     if m_nIndex<>-1 then
     Begin

      m_pDB.GetTPlanesTable(m_pPLTbl);
      for i:=0 to 3 do
      for j:=0 to m_pSZTbl.Count-1 do
      for k:=0 to m_pPLTbl.Count-1 do
      if (m_nIndex=m_pSZTbl.Items[j].m_swSZNID)and(m_nIndex<>0) then
      Begin
       m_pDB.DelTMTarifTable(m_pPLTbl.Items[k].m_swPLID,m_pSZTbl.Items[j].m_swSZNID,k,-1);
       m_pDB.DelSZTarifTable(m_nIndex);
      End;
      if m_nIndex=0 then MessageDlg('Нельзя удалить последнюю зону!',mtWarning,[mbOk,mbCancel],0);
      SetEditSz;
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
procedure CL3SznEditor.OnDelAllRow;
Var
    m_pPLTbl : TM_PLANES;
    i,j,k:Integer;
Begin
    m_pDB.GetTPlanesTable(m_pPLTbl);
    for i:=0 to 3 do
    for j:=0 to m_pSZTbl.Count-1 do
    for k:=0 to m_pPLTbl.Count-1 do
    if m_pSZTbl.Items[j].m_swSZNID<>0 then
    Begin
     m_pDB.DelTMTarifTable(m_pPLTbl.Items[k].m_swPLID,m_pSZTbl.Items[j].m_swSZNID,k,-1);
     m_pDB.DelSZTarifTable(m_pSZTbl.Items[j].m_swSZNID);
    End;
    MessageDlg('Последняя зона не будет удалена.',mtWarning,[mbOk,mbCancel],0);
    SetEditSz;
    ExecSetGrid;
End;
procedure CL3SznEditor.OnMDownSZN(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
Var
    dtFDateTime    : TDateTime;
    dtEDateTime : TDateTime;
Begin
    try
    if (Button=mbLeft)and(Shift=[ssCtrl,ssLeft]) then
    Begin
    if ((m_nColIndex=4)or(m_nColIndex=5))and(m_nRowIndex>0) then
    Begin
     if FsgGrid.Cells[m_nColIndex,m_nRowIndex]='' then exit;
     MCalendar.DateTimePicker1.DateTime := StrToDateTime(FsgGrid.Cells[m_nColIndex,m_nRowIndex]);
     if MCalendar.ShowModal=mrOK then
     Begin
       dtEDateTime := MCalendar.DateTimePicker1.DateTime;
       if m_nColIndex=5 then
       Begin
        FsgGrid.Cells[m_nColIndex,m_nRowIndex]   := DateTimeToStr(dtEDateTime);
        if dtEDateTime<=StrToDateTime(FsgGrid.Cells[m_nColIndex-1,m_nRowIndex]) then FsgGrid.Cells[m_nColIndex-1,m_nRowIndex] := DateTimeToStr(dtEDateTime);
       End;
       if m_nColIndex=4 then
       Begin
        dtFDateTime   := StrToDateTime(FsgGrid.Cells[5,m_nRowIndex]);
        if dtEDateTime<=dtFDateTime then FsgGrid.Cells[m_nColIndex,m_nRowIndex] := DateTimeToStr(dtEDateTime);
       End;

      End;
     End;
    End;
    except
    end;
End;

//Init Layer
procedure CL3SznEditor.OnInitLayer;
Begin
    //ExecSetTree;
    ExecInitLayer;
End;
//Index Generator
function  CL3SznEditor.GenIndex:Integer;
Var
    i : Integer;
Begin
    for i:=0 to MAX_TTYPE do
    if m_blSznTypeIndex[i]=True then
    Begin
     Result := i;
     exit;
    End;
    Result := -1;
End;
function  CL3SznEditor.GenIndexSv:Integer;
Begin
    Result := SetIndex(GenIndex);
End;
function CL3SznEditor.SetIndex(nIndex : Integer):Integer;
Begin
    m_blSznTypeIndex[nIndex] := False;
    Result := nIndex;
End;
Procedure CL3SznEditor.FreeIndex(nIndex : Integer);
Begin
    m_blSznTypeIndex[nIndex] := True;
End;
Procedure CL3SznEditor.FreeAllIndex;
Var
    i : Integer;
Begin
    for i:=0 to MAX_TTYPE do
    m_blSznTypeIndex[i] := True;
End;
procedure CL3SznEditor.OnExecute(Sender: TObject);
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
procedure CL3SznEditor.OnChannelGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
     OnGlGetCellColor(Sender,ARow,ACol,AState,ABrush,AFont);
end;
procedure CL3SznEditor.OnChannelGetCellType(Sender: TObject; ACol, ARow: Integer;var AEditor: TEditorType);
begin
    with FsgGrid^ do
    case ACol of
     6:Begin
        AEditor := edComboList;
        combobox.items.loadfromfile(m_strCurrentDir+'Active.dat');
       End;
    end;
end;
function CL3SznEditor.GetComboIndex(cbCombo:TComboBox;str:String):Integer;
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
