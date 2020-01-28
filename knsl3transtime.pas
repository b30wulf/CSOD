unit knsl3transtime;

interface
uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,ComCtrls,utltypes
    ,knsl5tracer, Dates,utlbox, utlTimeDate,math,utldatabase,RASUnit,utlmtimer,utlconst,WinSvc,Grids, BaseGrid, AdvGrid,knsl5calendar;
type
    CTransTime = class
    private
     m_pIniTbl       : PSGENSETTTAG;
     m_sbyEnable     : Boolean;
     m_pTable        : SL3TRANSTIMES;
     FsgGrid         : PTAdvStringGrid;
     m_nRowIndex     : Integer;
     m_nRowIndexEx   : Integer;
     m_nColIndex     : Integer;
     m_nIDIndex      : Integer;
     m_nAmRecords    : Integer;
     m_nIndex        : Integer;
     m_dwCounter     : Dword;
     m_strCurrentDir : String;
     FlbOnTransTime  : PTStaticText;
     FlbOnTransState : PTStaticText;
     m_blIsEdit      : Boolean;
     procedure LoadModule;
     procedure Proceed;
     function  IsEmpty:Boolean;

     function  FindRow(str:String):Integer;
     procedure ViewDefault;
     procedure ViewChild(nIndex:Integer);
     function  FindFreeRow(nIndex:Integer):Integer;
     procedure AddRecordToGrid(nIndex:Integer;pTbl:PSL3TRANSTIME);
     function  SetIndex(nIndex : Integer):Integer;
     function  GenIndex:Integer;
     function  GenIndexSv:Integer;
     procedure FreeIndex(nIndex : Integer);
     Procedure FreeAllIndex;
     procedure GetGridRecord(var pTbl:SL3TRANSTIME);
     procedure SetDefaultRow(i:Integer);
     procedure ExecSetGrid;
     procedure SetTransModule(Value: Boolean);
     function  FindTime(var nIndex:Byte):Integer;
     procedure SetAction(nIndex:Byte);
     procedure FindNextTrans;
    public
     procedure Init(pTable:PSGENSETTTAG);
     procedure OnFormResize;
     procedure OnTTimeGetCellType(Sender: TObject; ACol, ARow: Integer;var AEditor: TEditorType);
     procedure OnClickGrid(Sender: TObject; ARow, ACol: Integer);
     procedure OnMDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
     procedure Run;
     procedure OnSaveGrid;
     procedure OnSetGrid;
     procedure OnInitLayer;
     procedure OnDelRow;
     procedure OnDelAllRow;
     procedure OnAddRow;
     procedure OnCloneRow;
     procedure OnLoadModule;
     procedure OnSetMode;
    public
     property OnEnable        :Boolean         read m_sbyEnable      write SetTransModule;
     property PsgGrid         :PTAdvStringGrid read FsgGrid         write FsgGrid;
     property PlbOnTransTime  :PTStaticText    read FlbOnTransTime  write FlbOnTransTime;
     property PlbOnTransState :PTStaticText    read FlbOnTransState write FlbOnTransState;
    End;
var
    m_nTT1: CTransTime;
implementation
procedure CTransTime.Init(pTable:PSGENSETTTAG);
Var
     i : Integer;
Begin
     m_pIniTbl := pTable;
     m_strCurrentDir := ExtractFilePath(Application.ExeName) + '\\Settings\\';
     for i:=0 to MAX_TRTIME do m_blTransIndex[i] := True;
     m_blIsEdit          := False;
     m_dwCounter         := 0;
     m_nRowIndex         := -1;
     m_nColIndex         := 1;
     m_nRowIndexEx       := 2;
     m_nIDIndex          := 2;
     //FsgGrid.Color       := KNS_NCOLOR;
     FsgGrid.ColCount    := 7;
     FsgGrid.RowCount    := 30;
     FsgGrid.Cells[0,0]  := '№/T';
     FsgGrid.Cells[1,0]  := 'ID';
     FsgGrid.Cells[2,0]  := 'TMID';
     FsgGrid.Cells[3,0]  := 'В.Перехода';
     FsgGrid.Cells[4,0]  := 'Н.Время';
     FsgGrid.Cells[5,0]  := 'Состояние';
     FsgGrid.Cells[6,0]  := 'Активность';

     FsgGrid.ColWidths[0]:= 30;
     FsgGrid.ColWidths[1]:= 40;
     FsgGrid.ColWidths[2]:= 35;

     ExecSetGrid;
     FindNextTrans;
End;
procedure CTransTime.OnFormResize;
Var
    i : Integer;
Begin
    for i:=3 to FsgGrid.ColCount-1  do FsgGrid.ColWidths[i]  := trunc((FsgGrid.Width-75-2*FsgGrid.ColWidths[0])/(FsgGrid.ColCount-1-2));
    //if FChild<>Nil then FChild.OnFormResize;
End;
procedure CTransTime.ExecSetGrid;
Var
    i : Integer;
Begin
    FsgGrid.ClearNormalCells;
    if m_pDB.GetTransTimeTable(m_pTable)=True then
    Begin
     m_nAmRecords := m_pTable.Count;
     for i:=0 to m_pTable.Count-1 do
     Begin
      SetIndex(m_pTable.Items[i].m_swTRSID);
      AddRecordToGrid(i,@m_pTable.Items[i]);
     End;
     ViewDefault;
    End;
End;
procedure CTransTime.ViewDefault;
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
function CTransTime.FindRow(str:String):Integer;
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
procedure CTransTime.OnTTimeGetCellType(Sender: TObject; ACol, ARow: Integer;var AEditor: TEditorType);
begin
    with FsgGrid^ do
    case ACol of
    5:Begin
        AEditor := edComboList;
        combobox.items.loadfromfile(m_strCurrentDir+'stateproc.dat');
       End;
    6:Begin
        AEditor := edComboList;
        combobox.items.loadfromfile(m_strCurrentDir+'Active.dat');
       End;
    end;
end;

procedure CTransTime.AddRecordToGrid(nIndex:Integer;pTbl:PSL3TRANSTIME);
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
     FsgGrid.Cells[2,nY] := IntToStr(m_swTRSID);
     FsgGrid.Cells[3,nY] := DateTimeToStr(m_dtTime);
     FsgGrid.Cells[4,nY] := DateTimeToStr(m_dtTimeNew);
     FsgGrid.Cells[5,nY] := m_nStateProc.Strings[m_sbyState];
     FsgGrid.Cells[6,nY] := m_nActiveList.Strings[m_sbyEnable];
    End;
End;
procedure CTransTime.OnSetGrid;
Begin
    ExecSetGrid;
End;
procedure CTransTime.OnSaveGrid;
Var
    i : Integer;
    pTbl:SL3TRANSTIME;
Begin
    for i:=1 to FsgGrid.RowCount-1 do
    Begin
     if FsgGrid.Cells[3,i]='' then break;
     pTbl.m_swID := i;
     GetGridRecord(pTbl);
     if m_pDB.AddTransTimeTable(pTbl)=True then SetIndex(pTbl.m_swTRSID);
    End;
    ExecSetGrid;
End;
function CTransTime.FindFreeRow(nIndex:Integer):Integer;
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
procedure CTransTime.GetGridRecord(var pTbl:SL3TRANSTIME);
Var
    i : Integer;
    str : String;
Begin
    i := pTbl.m_swID;
    with pTbl do Begin
     SetDefaultRow(i);
     m_swID        := StrToInt(FsgGrid.Cells[1,i]);
     m_swTRSID     := StrToInt(FsgGrid.Cells[2,i]);
     m_dtTime      := StrToDateTime(FsgGrid.Cells[3,i]);
     m_dtTimeNew   := StrToDateTime(FsgGrid.Cells[4,i]);
     m_sbyState := m_nStateProc.IndexOf(FsgGrid.Cells[5,i]);
     m_sbyEnable    := m_nActiveList.IndexOf(FsgGrid.Cells[6,i]);
    End;
End;
procedure CTransTime.OnAddRow;
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
procedure CTransTime.OnCloneRow;
Var
    nIndex : Integer;
    pTbl   : SL3TRANSTIME;
Begin
    if m_nRowIndex<>-1 then
    if m_nRowIndex<=FindFreeRow(3)-1 then
    Begin
     pTbl.m_swID   := m_nRowIndex;
     GetGridRecord(pTbl);
     pTbl.m_swTRSID := GenIndexSv;
     AddRecordToGrid(FindFreeRow(3)-1,@pTbl);
    End;
End;
procedure CTransTime.ViewChild(nIndex:Integer);
Begin
    {
    if FChild<>Nil then
    Begin
     FChild.PMasterIndex := nIndex;
     FChild.ExecSetGrid;
    End;
    }
End;
//m_nStateProc
{
SL3TRANSTIME = packed record
     m_swID        : Integer;
     m_swTRSID     : Integer;
     m_dtTime      : TDateTime;
     m_dtTimeNew   : TDateTime;
     m_sbyState : Byte;
     m_sbyEnable    : Byte
    End;
}
procedure CTransTime.SetDefaultRow(i:Integer);
//Var
    //dtTM   : TDateTime;
    //wValue : Word;
Begin
    //wValue := 0;
    //DecodeDate(dtTM,wValue,wValue,wValue);
    //DecodeTime(dtTM,wValue,wValue,wValue,wValue);
    if FsgGrid.Cells[1,i]='' then FsgGrid.Cells[1,i] := '-1';
    if FsgGrid.Cells[2,i]='' then FsgGrid.Cells[2,i] := IntToStr(GenIndex);
    if FsgGrid.Cells[3,i]='' then FsgGrid.Cells[3,i] := DateTimeToStr(Now);
    if FsgGrid.Cells[4,i]='' then FsgGrid.Cells[4,i] := DateTimeToStr(Now);
    if FsgGrid.Cells[5,i]='' then FsgGrid.Cells[5,i] := m_nStateProc.Strings[0];
    if FsgGrid.Cells[6,i]='' then FsgGrid.Cells[6,i] := m_nActiveList.Strings[1];
End;
procedure CTransTime.OnClickGrid(Sender: TObject; ARow, ACol: Integer);
Begin
    m_nRowIndex   := -1;
    m_nColIndex   := -1;
    m_nRowIndexEx := -1;
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
procedure CTransTime.OnMDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
Var
    //dtFDateTime    : TDateTime;
    dtEDateTime : TDateTime;
Begin
    try
    if (Button=mbLeft)and(Shift=[ssCtrl,ssLeft]) then
    Begin
    if ((m_nColIndex=3)or(m_nColIndex=4))and(m_nRowIndex>0) then
    Begin
     if FsgGrid.Cells[m_nColIndex,m_nRowIndex]='' then exit;
     MCalendar.DateTimePicker1.DateTime := StrToDateTime(FsgGrid.Cells[m_nColIndex,m_nRowIndex]);
     MCalendar.Position := poOwnerFormCenter;
     if MCalendar.ShowModal=mrOK then
     Begin
       dtEDateTime := MCalendar.DateTimePicker1.DateTime;
       FsgGrid.Cells[m_nColIndex,m_nRowIndex] := DateTimeToStr(dtEDateTime);
       {
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
       }
      End;
     End;
    End;
    except
    end;
End;
procedure CTransTime.OnDelRow;
Var
    nFind : Integer;
Begin
    if m_nAmRecords=FindFreeRow(3)-1 then
    Begin
     if m_nIndex<>-1 then
     Begin
      FreeAllIndex;
      m_pDB.DelTransTimeTable(m_nIndex);
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
procedure CTransTime.OnDelAllRow;
Begin
    m_pDB.DelTransTimeTable(-1);
    FreeAllIndex;
    ExecSetGrid;
End;
//Init Layer
procedure CTransTime.OnInitLayer;
Begin
    //ExecSetTree;
    //ExecInitLayer;
End;
//Index Generator
function  CTransTime.GenIndex:Integer;
Var
    i : Integer;
Begin
    for i:=0 to MAX_TRTIME do
    if m_blTransIndex[i]=True then
    Begin
     Result := i;
     exit;
    End;
    Result := -1;
End;
function  CTransTime.GenIndexSv:Integer;
Begin
    Result := SetIndex(GenIndex);
End;
function CTransTime.SetIndex(nIndex : Integer):Integer;
Begin
    m_blTransIndex[nIndex] := False;
    Result := nIndex;
End;
Procedure CTransTime.FreeIndex(nIndex : Integer);
Begin
    m_blTransIndex[nIndex] := True;
End;
Procedure CTransTime.FreeAllIndex;
Var
    i : Integer;
Begin
    for i:=0 to MAX_TRTIME do
    m_blTransIndex[i] := True;
End;

//Trans Time Routine


procedure CTransTime.OnLoadModule;
Begin
    LoadModule;
End;
procedure CTransTime.LoadModule;
Begin
    ExecSetGrid;
End;
function CTransTime.FindTime(var nIndex:Byte):Integer;
Var
    i : Integer;
    y0,mt0,d0    : Word;
    y1,mt1,d1    : Word;
    h0,m0,s0,ms0 : Word;
    h1,m1,s1,ms1 : Word;
Begin
    try
    Result := 0;    
    for i:=0 to m_pTable.Count-1 do
    Begin
     with m_pTable.Items[i] do
     Begin
      if m_sbyState = 0 then
      Begin
       DecodeTime(m_dtTime,h0,m0,s0,ms0);
       DecodeTime(Now,h1,m1,s1,ms1);
       DecodeDate(m_dtTime,y0,mt0,d0);
       DecodeDate(Now,y1,mt1,d1);
       if (y0=y1)and(mt0=mt1)and(d0=d1)and(h0=h1)and(m0=m1) then
       Begin
        m_sbyState := 2;
        m_pDB.AddTransTimeTable(m_pTable.Items[i]);
        FsgGrid.SelectRows(i+1,1);
        if (i-FsgGrid.VisibleRowCount)>0  then FsgGrid.TopRow := i-FsgGrid.VisibleRowCount+2 else FsgGrid.TopRow := 1;
        if i>=0 then
        Begin
         FsgGrid.Cells[5,i+1]   := m_nStateProc.Strings[m_sbyState];
         if (i+1)<=m_pTable.Count-1 then
         PlbOnTransState.Caption := 'C '+DateTimeToStr(m_pTable.Items[i+1].m_dtTime)+' на '+DateTimeToStr(m_pTable.Items[i+1].m_dtTimeNew) else
         if i=0 then PlbOnTransState.Caption := 'C '+DateTimeToStr(m_pTable.Items[0].m_dtTime)+' на '+DateTimeToStr(m_pTable.Items[i+1].m_dtTimeNew);
        End;
        nIndex := i;
        if m_sbyEnable=1 then Result := 1 else
        if m_sbyEnable=0 then Result := 0;
        exit;
       End;
      End;
     End;
    End;
    except
     Result := 0;
    End;
     //Result := 0;
End;
procedure CTransTime.FindNextTrans;
Var
     i : Integer;
Begin
     if m_sbyEnable=True then
     for i:=0 to m_pTable.Count-1 do
     Begin
      if m_pTable.Items[i].m_sbyState=0 then
      Begin
       FsgGrid.SelectRows(i+1,1);
       PlbOnTransState.Caption := 'C '+DateTimeToStr(m_pTable.Items[i].m_dtTime)+' на '+DateTimeToStr(m_pTable.Items[i].m_dtTimeNew);
       exit;
      End else PlbOnTransState.Caption := 'Все переходы выполнены';
     End;
End;
procedure CTransTime.SetAction(nIndex:Byte);
var
     Time : _SYSTEMTIME;
     dt   : TDateTime;
     y0,mt0,d0    : Word;
     h0,m0,s0,ms0 : Word;
Begin
     try
      GetLocalTime(Time);
      dt := m_pTable.Items[nIndex].m_dtTimeNew;
      DecodeDate(dt,y0,mt0,d0);
      DecodeTime(dt,h0,m0,s0,ms0);
      //Time.wMilliseconds := 0;
      //Time.wSecond       := s0;
      Time.wMinute       := m0;
      Time.wHour         := h0;
      Time.wDay          := d0;
      Time.wMonth        := mt0;
      Time.wYear         := y0;
      Time.wDayOfWeek    := DayOfWeek(dt);
      SetLocalTime(Time);       ///  EVH_AUTO_GO_TIME
//      m_pDB.FixUspdEvent(0,3,EVH_AUTO_GO_TIME);
     except
      TraceER('(__)CSTTM::>Error In CTransTime.SetAction!!!');
     end;
End;
procedure CTransTime.Proceed;
Var
     nIndex : Byte;
Begin
     if (m_dwCounter mod 10)=0 then
     Begin
      case FindTime(nIndex) of
        1  : SetAction(nIndex);
      End;
     End;
     m_dwCounter := m_dwCounter + 1;
End;
function CTransTime.IsEmpty:Boolean;
Begin
  Result := False;
End;
procedure CTransTime.SetTransModule(Value: Boolean);
Begin
  {   m_sbyEnable := Value;
     //m_pDB.SetEnTransTime(Byte(m_sbyEnable));
     //if m_pIniTbl<>Nil then m_pIniTbl.m_sTransTime := Byte(m_sbyEnable);
     if m_sbyEnable=True  then
     Begin
      PlbOnTransTime.Caption := 'Включен';
      FindNextTrans;
     End else
     if m_sbyEnable=False then
     Begin
      PlbOnTransTime.Caption  := 'Выключен';
      PlbOnTransState.Caption := 'Системный'; 
     End;                               }
End;
procedure CTransTime.OnSetMode;
Begin
    if m_blIsEdit=False then
    Begin
     m_blIsEdit := True;
     FsgGrid.Options := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goDrawFocusSelected,goColSizing,goEditing];
//     m_pDB.FixUspdEvent(0,3,EVS_TTIME_ED_ON);
    End else
    if m_blIsEdit=True then
    Begin
     FsgGrid.Options := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goRangeSelect,goDrawFocusSelected,goColSizing,goRowSelect];
//     m_pDB.FixUspdEvent(0,3,EVS_TTIME_ED_OF);
     m_blIsEdit := False;
    End;
End;
procedure CTransTime.Run;
Begin
     if m_sbyEnable=True then Proceed;
End;
end.
 